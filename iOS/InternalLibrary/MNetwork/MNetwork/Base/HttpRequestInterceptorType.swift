//
//  HttpRequestInterceptorType.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Alamofire
import Foundation
import MModels
import MUtility

// MARK: - HttpRequestInterceptorType

public protocol HttpRequestInterceptorType: RequestAdapter, RequestRetrier {
    var accessToken: String? { get set }
    var tokenRefresher: TokenRefresherType? { get set }
}

// MARK: - TokenRefresherType

public protocol TokenRefresherType: AnyObject {
    func refresh(_ completion: DecodableCompletion<AuthTokenDTO>?)
}

// MARK: - HttpRequestInterceptor

public final class HttpRequestInterceptor {
    // Definations

    enum Retry {
        static let shouldRetry = true
        static let shouldNotRetry = false
        static let limit = 3
    }

    private enum Delay {
        static let immediate: TimeInterval = DispatchTimeInterval.immediate.toTimeInterval()
    }

    public var accessToken: String?
    public weak var tokenRefresher: TokenRefresherType?
    private let modartDomain: String

    private let serialQueue = DispatchQueue(label: NSStringFromClass(HttpRequestInterceptor.self), qos: .background)
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    private var retryCount = 0

    public convenience init(environment: NetworkEnvironment) {
        self.init(modartDomain: DomainConfigurator.domain(environment: environment))
    }

    public init(modartDomain: String) {
        self.modartDomain = modartDomain
    }
}

// MARK: - HttpRequestInterceptorType

extension HttpRequestInterceptor: HttpRequestInterceptorType {

    /// Implement RequestRetriver
    // A type that determines whether a request should be retried after being executed by the specified session manager
    /// and encountering an error.
    /// Should retry method, get called after having an error response
    public func should(
        _ manager: SessionManager,
        retry request: Request,
        with error: Error,
        completion: @escaping RequestRetryCompletion
    ) {
        // Lint will pass if I remove all the logs. But let's keep all of them for now -- JLI 15/01/20
        // swiftlint:disable closure_body_length
        serialQueue.async { [weak self] in
            Log.debug("[Auto Retry] Request \(request.request?.url?.absoluteString ?? "")")
            // Cope with token expire condition
            guard
                let self = self,
                let tokenRefresher = self.tokenRefresher, // No retry if the refresher is nil
//                let url = request.request?.url,
//                url.isDigitalBankRequest,
                request.isUnauthorized()
            else {
                // For requests don't need to retry **this time**, Call the completion directly
                Log.debug("[Auto Retry] No Retry")
                completion(Retry.shouldNotRetry, Delay.immediate)
                return
            }

            Log.debug("[Auto Retry] append request")
            self.requestsToRetry.append(completion)

            Log.debug("[Auto Retry] isRefreshing = \(self.isRefreshing)")
            guard
                !self.isRefreshing
            else {
                return // All the rest of requests are added into the queue but do nothing
            }

            // only the 1st request in the queue does the refresh
            self.isRefreshing = true

            Log.debug("[Auto Retry] trigger refresh currentRetryCount = \(self.retryCount)")
            if self.retryCount < Retry.limit {
                self.retryCount += 1
                Log.debug("[Auto Retry] trigger refresh currentRetryCount = \(self.retryCount)")
                tokenRefresher.refresh { [weak self] result in
                    self?.serialQueue.async {
                        guard let self = self else { return }
                        Log.debug("[Auto Retry] refresh result = \(result)")
                        self.isRefreshing = false

                        if case .success = result {
                            Log.debug("[Auto Retry] reset retry count")
                            self.retryCount = 0
                        }

                        self.requestsToRetry.forEach { $0(Retry.shouldRetry, Delay.immediate) }
                        self.requestsToRetry.removeAll()
                    }
                }
            } else {
                Log.debug("[Auto Retry] over retry limit")
                self.retryCount = 0
                self.isRefreshing = false

                self.requestsToRetry.forEach { $0(Retry.shouldNotRetry, Delay.immediate) }
                self.requestsToRetry.removeAll()
            }
        }
    }


    /// Implement RequestAdapter
    /// All requests sent by an Alamofire.sessionManager will go through here first. Includes retry requests
    ///
    /// - Parameter urlRequest: the original request
    /// - Returns: the original request or a updated request
    /// - Throws: error if something wrong
    public func adapt(
        _ urlRequest: URLRequest
    ) throws -> URLRequest {
        guard
            let accessToken = accessToken,
            urlRequest.url?.absoluteString.contains(modartDomain) ?? false
        else {
            Log.debug("[Auto Retry] header untouched")
            return urlRequest
        }

        Log.debug("[Auto Retry] attaching Access Token \"...\(accessToken.suffix(4))\"")
        var request = urlRequest
        request.setAuthToken(accessToken)
        return request
    }
}

extension URLRequest {

    mutating func setAuthToken(_ token: String) {
        setValue("\(HttpHeader.Authorization.valuePrefixBearer) \(token)",
                 forHTTPHeaderField: HttpHeader.Authorization.key)
    }
}

extension Request {

    // Mark it objc to make it overridable to facilitate unit tests.
    @objc
    open func isUnauthorized() -> Bool {
        response?.statusCode.code == HttpStatus.Code.unauthorized
    }
}
