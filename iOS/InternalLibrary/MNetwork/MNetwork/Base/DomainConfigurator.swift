//
//  DomainConfigurator.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MUtility

// https://docs.google.com/document/d/1cJRdaFCRrGsfVsd7ZWkbE14WPw3wBkE0yhAyX-_rmR0/edit
public struct DomainConfigurator {
    public static func domain(environment: NetworkEnvironment) -> String {
        if Macros.isRunningUITests {
            return "localhost:9080"
        }

        switch environment {
        /* cspell:disable */
        case .dev:
            return "api.windy.com"

        case .staging:
            return ""

        case .production:
            return ""
        /* cspell:enable */
        }
    }

    // AUTH_KEY
    public static func clientId(environment: NetworkEnvironment) -> String {
        switch environment {
        case .dev : return ""
        case .staging: return ""
        case .production: return ""
        }
    }

    public static func clientSecret(environment: NetworkEnvironment) -> String {
        switch environment {
        case .dev: return ""
        case .staging: return ""
        case .production: return ""
        }
    }

    public static func basePath(environment: NetworkEnvironment) -> String {
        let scheme = URLSchemeResolver.protocol()
        let domainName = domain(environment: environment)
        return "\(scheme)\(domainName)".lowercased()
    }
}
