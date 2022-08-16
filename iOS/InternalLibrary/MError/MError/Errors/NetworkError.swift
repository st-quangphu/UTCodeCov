//
//  NetworkError.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MResources

public final class NetworkError: MError {
    private init(
        errorType: ErrorType,
        errorCode: Int,
        message: String = ResourceStrings.Alert.Message.connectionError
    ) {
        super.init(
            errorType: errorType,
            message: message,
            errorCode: String(errorCode)
        )
    }

    public convenience init(error: Error) {
        let error = error as NSError
        let errorType: ErrorType

        switch error.code {
        case NSURLErrorTimedOut where error.domain == NSURLErrorDomain:
            errorType = .networkTimeout

        case NSURLErrorNotConnectedToInternet where error.domain == NSURLErrorDomain:
            errorType = .noNetworkConnection

        default:
            errorType = .network
        }

        self.init(errorType: errorType, errorCode: error.code)
    }
}
