//
//  ApiUrlProviderType.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MUtility

// MARK: - ApiUrlProviderType

protocol ApiUrlProviderType {
    func url(for api: Endpoint, environment: NetworkEnvironment) -> URL?
}

// MARK: - ApiUrlProvider

public struct ApiUrlProvider: ApiUrlProviderType {

    public func url(for api: Endpoint, environment: NetworkEnvironment) -> URL? {
        let basePath = DomainConfigurator.basePath(environment: environment)
        return URL(string: "\(basePath)\(api.version)\(api.fullPath)")
    }
}
