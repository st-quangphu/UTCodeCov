//
//  DataError.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MResources

public final class DataError: MError {
    public enum Reason {
        case encoding
        case decoding
        case parsing
        case filtering
        case sorting
    }

    let systemDescription: String?

    public init(reason: Reason, message: String? = nil, systemDescription: String? = nil) {
        self.systemDescription = systemDescription
        let errorType: ErrorType
        let title = ResourceStrings.Common.Error.title
        let errorCode: ErrorCode.Data

        switch reason {
        case .encoding:
            errorType = .encoding
            errorCode = ErrorCode.Data.encoding

        case .decoding:
            errorType = .decoding
            errorCode = ErrorCode.Data.decoding

        case .parsing:
            errorType = .parsing
            errorCode = ErrorCode.Data.parsing

        case .filtering:
            errorType = .filtering
            errorCode = ErrorCode.Data.filtering

        case .sorting:
            errorType = .sorting
            errorCode = ErrorCode.Data.sorting
        }

        super.init(errorType: errorType, title: title, message: message, errorCode: String(errorCode.rawValue))
    }
}
