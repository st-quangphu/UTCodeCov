//
//  ApiError.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MResources

public final class ApiError: MError {
    public enum Reason {
        case responseValidation(statusCode: Int)
    }

    public init(reason: Reason) {
        let errorType: ErrorType
        let title = ResourceStrings.Common.Error.title
        let message = ResourceStrings.Alert.Message.connectionError
        let errorCode: Int

        switch reason {
        case let .responseValidation(statusCode):
            errorType = .response
            errorCode = statusCode
        }

        super.init(errorType: errorType, title: title, message: message, errorCode: String(errorCode))
    }
}
