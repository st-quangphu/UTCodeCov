//
//  URLSchemeResolver.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MUtility

public struct URLSchemeResolver {
    public static func `protocol`() -> String {
        Macros.isRunningUITests ? Constants.http : Constants.https
    }
}

// MARK: - Constants

private extension URLSchemeResolver {

    enum Constants {
        static let https = "https://"
        static let http = "http://"
    }
}
