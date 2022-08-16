//
//  EndPoint+URLRequest.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MError
import MUtility

extension Endpoint {
    func toURLRequest(
        urlProvider: ApiUrlProviderType,
        environment: NetworkEnvironment,
        defaultHeaders: HttpHeaders
    ) throws -> URLRequest {
        let endpointURL: URL
        // Check if `customURL` is implemented. Otherwise, construct using URL provider.
        if let customURL = customURL {
            endpointURL = customURL
        } else {
            // Crash on programmer error in URL creation.
            endpointURL = urlProvider.url(for: self, environment: environment)!
        }

        var request = URLRequest(
            url: endpointURL,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: timeout
        )
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = defaultHeaders.merging(headers, uniquingKeysWith: { _, last in last })

        do {
            switch requestType {
            case .requestPlain: break

            case let .requestUrlParameters(urlParameters):
                request = try requestType.encoding.encode(request, with: urlParameters)

            case .requestJSONEncodable, .requestRawParameters:
                request = try requestType.encoding.encode(request, with: requestType.parameters)
            }
        } catch {
            throw DataError(reason: .encoding, message: error.localizedDescription)
        }

        return request
    }
}
