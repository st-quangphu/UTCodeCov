//
//  ExampleApiClients.swift
//  MNetwork
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation
import MModels
import MUtility

public protocol ExampleApiClientType {
    func find(key: String, completion: DecodableCompletion<String>?)
}

public struct ExampleApiClient {
    public let apiClient: ApiClientType
    private let environment: NetworkEnvironment

    public init(apiClient: ApiClientType, environment: NetworkEnvironment) {
        self.apiClient = apiClient
        self.environment = environment
    }
}

extension ExampleApiClient: ExampleApiClientType {
    public func find(key: String, completion: DecodableCompletion<String>?) {
        apiClient.request(
            ExampleEndpoint.find(key: key),
            decodableResponseType: .body,
            completion: completion
        )
    }
}
