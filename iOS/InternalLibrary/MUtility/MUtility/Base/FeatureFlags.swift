//
//  FeatureFlags.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public enum FeatureFlags {
    public static var enableTestUser: Bool {
        Macros.isDebug
    }

    public static var enableNetworkStub: Bool {
        Macros.isDemoMode
    }

    public static var environment: NetworkEnvironment? {
        Macros.environment
    }

    public static var eraseDatabaseOnSchemaChange: Bool {
        // reset db when having schema changes for now.
        // This should be turned off after having a public release
        // in favor of having an appropriate schema migrations
        false
    }

    /// Log entries for network requests sent by the APIClient
    public static var logNetworkRequest: Bool {
        Macros.isDebug
    }

    /// Log entries for network request responses received by the APIClient
    public static var logNetworkResponses: Bool {
        true
    }

    public static var enableCertificatePinning: Bool {
        // It's easy to commit this file in false mode, which can be big security risk.
        // Let's use non debug environment for enabling certificate pinning
        !Macros.isDebug
    }
}
