//
//  Error+NSURLError.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public enum ErrorCodes {
    static let network = [
        NSURLErrorTimedOut,
        NSURLErrorCannotFindHost,
        NSURLErrorCannotConnectToHost,
        NSURLErrorNetworkConnectionLost,
        NSURLErrorDNSLookupFailed,
        NSURLErrorNotConnectedToInternet,
        NSURLErrorInternationalRoamingOff,
        NSURLErrorCallIsActive,
        NSURLErrorDataNotAllowed
    ]
}

public extension Error {

    func isNetworkRequestTimeOut() -> Bool {
        code == NSURLErrorTimedOut ? true : false
    }

    func isNetworkError() -> Bool {
        ErrorCodes.network.contains(code)
    }

    func isSSLCertificatePinningError() -> Bool {
        domain == NSURLErrorDomain && code == NSURLErrorCancelled
    }
}
