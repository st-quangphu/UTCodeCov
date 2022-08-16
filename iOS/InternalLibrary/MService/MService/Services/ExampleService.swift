//
//  ExampleService.swift
//  MService
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation
import MModels
import MNetwork

public protocol ExampleServiceType {
    func find(key: String, completion: Completion<String>?)
}

public class ExampleService {
    private let apiClient: ExampleApiClientType

    public init(apiClient: ExampleApiClientType) {
        self.apiClient = apiClient
    }
}

extension ExampleService: ExampleServiceType {
    public func find(key: String, completion: Completion<String>?) {
        apiClient.find(key: key) { result in
            switch result {
            case .success(let data): completion?(.success(data))
            case .failure(let e): completion?(.failure(e))
            }
        }
    }
}
