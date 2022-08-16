//
//  ServerError.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MResources

// This Error includes HTTP errors
public final class ServerError: MError {

    /// Constructs a server error object
    /// - Parameter message: the error description passed from the server
    /// - Parameter errorCode: the error code passed from the server
    public init(message: String? = nil, errorCode: Int, underlyingErrorJson: [String: Any]? = nil) {
        let errorType: ErrorType = .server
        let title: String
        let msg: String?

        switch errorCode {
        case 503:
            title = ResourceStrings.Error._503.Alert.title
            msg = ResourceStrings.Error._503.Alert.message

        case 500..<600:
            title = ResourceStrings.Error._5xx.Alert.title
            msg = ResourceStrings.Error._5xx.Alert.message

        default:
            title = ResourceStrings.Common.Error.title
            msg = message
        }

        super.init(
            errorType: errorType,
            title: title,
            message: msg,
            errorCode: String(errorCode),
            underlyingErrorJson: underlyingErrorJson
        )
    }
}
