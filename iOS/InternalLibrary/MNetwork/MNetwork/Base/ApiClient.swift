//
//  ApiClient.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MError
import MModels
import MResources
import MUtility

// ✓ BaseURL has to be changeable
// ✓ Support multi regions
// ✓ HTTPS Pinning - See SessionManager+Configuration.swift
// Retry on Token Expiration
// Centralized Error handling
// If-Modified-Since
// Paging
// Rx-extension
// ✓ Cancellable Request
// Mockable response to facilitate upper layers' unit tests
// Change Region by resource server in credential
// ✓ API Versioning
// ✓ Run unit tests on CI
// Create an API test account on Staging
// Run API tests nightly on CI, with a ReadMe file for explanation
// Test cases for exceptions in the middle
// Consider to check the token expiration proactively and refresh before it is expired.
public protocol ApiClientType {
    /// Designated request-making method. Returns a request object which could be cancelled later.
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        decodableResponseType: DecodableResponseType,
        completion: DecodableCompletion<T>?
    )

    // Didn't omit the interceptor name as we have attach(nil) cases -- JLI 01/07/19
    func attach(interceptor: HttpRequestInterceptorType?)
}

// MARK: -

public class ApiClient {
    public static let API_VERSION = 1

    private let defaultHeaders: HttpHeaders
    private let urlProvider: ApiUrlProviderType
    private let sessionManager: SessionManageable
    public let environment: NetworkEnvironment

    /// Kill-switch to deactivate the APIClient. Requests won't be sent when this flag is set to false
    /// This is a temporary fix for an issue where APIClients are not being destroyed after logout, which
    /// causes certain requests to still be sent but without an AuthToken; this, in turn, triggers a forced-logout.
    ///
    /// We are keeping this for the time being, as our canary in a coal mine, to be alerted about memory leaks
    /// retaining instances of the ApiClient after logout.
    /// It will be removed once we add a mechanism to test for memory leaks in our view controllers.
    ///
    /// More info: [BCN-3506](https://moneytree-app.atlassian.net/browse/BCN-3506)
    private var isActive = true

    public let notificationCenter: NotificationCenter

    public convenience init(
        environment: NetworkEnvironment,
        apiKey: String,
        sessionManager: SessionManageable,
        notificationCenter: NotificationCenter = .default
    ) {
        self.init(
            urlProvider: ApiUrlProvider(),
            environment: environment,
            apiKey: apiKey,
            sessionManager: sessionManager
        )
        Log.debug("ApiClient initialized")
    }

    private init(
        urlProvider: ApiUrlProviderType,
        environment: NetworkEnvironment,
        apiKey: String,
        sessionManager: SessionManageable,
        notificationCenter: NotificationCenter = .default
    ) {
        self.urlProvider = urlProvider
        self.environment = environment
        self.sessionManager = sessionManager
        self.notificationCenter = notificationCenter

        // Turn off the default redirection action, because when we get state from the bcn digital bank service,
        // it contains a redirect action.
        sessionManager.delegate.taskWillPerformHTTPRedirection = { _, _, _, _ -> URLRequest? in
            nil
        }

        _ = DomainConfigurator.clientId(environment: environment)
        defaultHeaders = [
            HttpHeader.ContentType.key: HttpHeader.ContentType.jsonValue,
            HttpHeader.Accept.key: HttpHeader.Accept.value
        ]

        /// On application logout, deactivate.
        notificationCenter.addObserver(
            self,
            selector: #selector(deactivate),
            name: .userLoggedOut,
            object: nil
        )
    }

    @objc
    private func deactivate() {
        Log.debug("Deactivating APIClient after logout. This APIClient instance SHOULD be deallocated soon")
        isActive = false
    }
}

// MARK: - ApiClientType

extension ApiClient: ApiClientType {
    public func request<T>(
        _ endpoint: Endpoint,
        decodableResponseType: DecodableResponseType,
        completion: DecodableCompletion<T>?
    ) where T: Decodable {
        guard isActive else {
            Log.warning(
                """
                Deactivated APIClient attempting to fire a network request [\(endpoint.fullPath)]. Bailing out...
                """
            )
            assertionFailure(
                """
        After logout, all services are supposed to be cleaned.  The fact that an instance of ApiClient is retained
        in memory well after logout (when we deactivate them) is an indicator of the presence of a memory leak
        somewhere, causing a viewController not to be deallocated, retaining its viewModel with all of its dependencies.
        """
            )
            return
        }
        guard let dataRequest = try? request(endpoint) else {
            // This is a programmer error, so it should crash.
            fatalError("Unable to create valid request for endpoint: \(endpoint)")
        }

        dataRequest.responseData(queue: networkDispatchQueue) { [self] response in
            response.debugLog()

            switch response.result {
            case .failure:
                let error = self.processFailureResponse(response: response, decoder: endpoint.responseDecoder)

                if endpoint.showsErrorsToGuest || error.isCertificatePinningError {
                    completion?(.failure(error))
                } else {
                    completion?(.failure(UIIgnorableError(error)))
                }

            case let .success(data):
                self.processSuccessResponse(
                    response: response,
                    responseData: data,
                    decodableResponseType: decodableResponseType,
                    decoder: endpoint.responseDecoder,
                    completion: completion
                )
            }
        }
    }

    public func attach(interceptor: HttpRequestInterceptorType?) {}
}

// MARK: - ForcedLogoutPublisher

extension ApiClient: ForcedLogoutPublisher {}

// MARK: - Request Helpers

private extension ApiClient {
    func request(_ endpoint: Endpoint) throws -> DataRequest {
        let urlRequest: URLRequest

        do {
            urlRequest = try endpoint.toURLRequest(
                urlProvider: urlProvider,
                environment: environment,
                defaultHeaders: defaultHeaders
            )
        } catch {
            throw error
        }

        return sessionManager
            .request(urlRequest)
            .debugLog()
            .validate { _, response, _ in
                let isValid: Bool

                switch endpoint.validationType {
                case .none:
                    isValid = true

                case .successCodes:
                    isValid = response.statusCode.group == .successful

                case .successAndRedirectCodes:
                    isValid = [
                        HttpStatus.Group.successful,
                        HttpStatus.Group.redirection
                    ].contains(response.statusCode.group)

                case let .customCodes(codes):
                    isValid = codes.contains(response.statusCode.code!)
                }

                guard isValid else {
                    let e = ApiError(reason: .responseValidation(statusCode: response.statusCode))
                    return ValidationResult.failure(e)
                }
                return ValidationResult.success
            }
    }
}

// MARK: - Response Helpers

private extension ApiClient {
    /// Used to process the successful API response from Alamofire
    func processSuccessResponse<T: Decodable>(
        response: DataResponse<Data>,
        responseData: Data,
        decodableResponseType: DecodableResponseType,
        decoder: AnyDecoder,
        completion: DecodableCompletion<T>?
    ) {
        switch decodableResponseType {
        // After removing the connect to bcn logic, we don't have any use cases
        // But let's keep the logic for now. -- JLI 22/01/20
        /// Decode the required header field and return the result as a generic type (usually a String)
        case let .header(headerField):
            if let redirect = response.response?.allHeaderFields[headerField.key] as? T {
                completion?(.success(redirect))
            } else {
                completion?(.failure(DataError(
                    reason: .parsing,
                    message: ResourceStrings.Alert.Message.connectionError,
                    systemDescription: "Failed to parse the header \(headerField.key) in the response."
                )))
            }

        /// Decode the body and return the result as a generic type or return a decoding error if decoding fails
        case .body:
            do {
                let responseObject = try responseData.decoded(using: decoder) as T
                completion?(.success(responseObject))
            } catch {
                Log.debug(
                    """
          Failed to decode response \(response.request?.url?.absoluteString ?? "").
          \(responseData.toString() ?? "")
          \(error)
          """
                )
                completion?(.failure(DataError(reason: .decoding, message: error.localizedDescription)))
            }

        case .data:
            guard let data = responseData as? T else {
                assertionFailure("T has to be Data Type in the data case")
                let e = DataError(reason: .parsing, message: "Cannot convert to Data Type in the data case")
                completion?(.failure(e))
                return
            }
            completion?(.success(data))

        case .none:
            guard
                let response = EmptyResponse() as? T
            else {
                assertionFailure("T has to be EmptyResponse Type in the none case")
                // Unlikely to happen at runtime as long as we call the api with the right response type in the code -- JLI 22/01/20
                completion?(.failure(DataError(reason: .parsing, message: "EmptyResponse Type in the none case")))
                return
            }

            completion?(.success(response))
        }
    }

    /// Process the failure API response from Alamofire into an error.
    /// Note that a 401 (unauthorized) response will trigger a side effect of forcing logout, regardless of any other error handling requirements.
    /// Also note that a `must_relink` error will get wrapped in a `UIIgnorableError`.
    func processFailureResponse(
        response: DataResponse<Data>,
        decoder: AnyDecoder
    ) -> MError {
        // Keeping the logs below for debug purposes, may consider removing them in the future -- JLI 13/11/19
        if let error = response.result.error {
            Log.debug(error.localizedDescription)
        }
        if let errorMessage = response.data?.toString() {
            Log.debug("\(response.request?.url?.absoluteString ?? "")\n\(errorMessage)")
        }

        if let error = response.result.error {
            if error.isSSLCertificatePinningError() {
                // In production this error would require immediate action.
                // ↓ Remote logging for this event should be considered.  -- EME 4/5/20
                Log.error("SSL Certificate Pinning error. Certificates do not match.")
                return SecurityError.invalidSSLCertificate()
            }

            if error.isNetworkError() {
                // No need to attempt parsing a ServerErrorDTO in this case.
                return NetworkError(error: error)
            }
        }

        // Login does not return 401 (unauthorized) for the wrong username or password.
        // Thus, all 401 cases will force a logout.
        if response.response?.statusCode == HttpStatus.Code.unauthorized.rawValue {
            // However, we still return the appropriate error type even when we post force logout notification,
            // because an API client might want to rollback changes in the API completion block.
            Log.warning("Received HTTP 401 (Unauthorized) [\(response.request?.url?.absoluteString ?? String())]")
            Log.warning("Forcing logout...")
            publishForcedLogoutNotification(message: nil)
        }

        if response.data?.isEmpty ?? true, let error = response.error as? MError {
            return error
        }

        // Handle Server Error
        do {
            let serverErrorDTO = try response.data!.decoded(using: decoder) as ServerErrorDTO
            let underlyingErrorJson = try? JSONSerialization
                .jsonObject(with: response.data!, options: []) as? [String: Any]
            let serverError = ServerError(
                serverErrorDTO: serverErrorDTO,
                errorCode: response.response?.statusCode,
                underlyingErrorJson: underlyingErrorJson
            )
            return serverError
        } catch let decodeError {
            // We want to provide a generic user-facing message and also preserve the localized description for debugging.
            return DataError(
                reason: .decoding,
                message: ResourceStrings.Alert.Message.connectionError,
                systemDescription: decodeError.localizedDescription
            )
        }
    }
}

// MARK: - Request Logger

private extension Request {
    func debugLog() -> Self {
        guard FeatureFlags.logNetworkRequest else { return self }
        Log.debug(
            """
      Request sent:
      ────────────────────────────────────────────────
      \(debugDescription)
      ────────────────────────────────────────────────
      """
        )
        return self
    }
}

// MARK: - Response Logger

private extension DataResponse where Value == Data {
    func debugLog() {
        guard FeatureFlags.logNetworkResponses else { return }

        switch result {
        case let .success(data):
            Log.error(
                """
        statusCode = \(response?.statusCode ?? -1)
        Response for [\(request?.url?.absoluteString ?? "nil")]:
        ────────────────────────────────────────────────
        \(data.toString() ?? "")
        ────────────────────────────────────────────────
        """
            )

        default:
            break
        }
    }
}
