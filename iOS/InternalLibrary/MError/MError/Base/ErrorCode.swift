//
//  ErrorCode.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation

// Disable the number separator here as we often need to refer to the error code
public enum ErrorCode: Int {
    // 9999 undefined error
    case undefined = 9_999

    // 11xx
    public enum UserDefaults {}

    // 12xx

    // 13xx
    public enum API: Int {
        case invalidRequestUrl = 1_301
        case requestCreation = 1_302
        case responseValidation = 1_303
    }

    // 14xx
    public enum Data: Int {
        case encoding = 1_401
        case decoding = 1_402
        case parsing = 1_403
        case filtering = 1_404
        case sorting = 1_405
    }

    // 15xx
    public enum Server: Int {
        case unknownServerError = 1_501
    }

    // 16xx
    public enum Service: Int {
        case objectNotFound = 1_601
    }

    // 17xx
    public enum Application: Int {
        case invalidIndexPath = 1_701
    }

    // 18xx
    public enum Authentication: Int {
        case passcodeValidationAttemptsExceeded = 1_801
        case operationCanceledByUser = 1_802
    }

    // 19xx
    public enum Votp: Int {
        case invalidCode = 1_901
    }

    // 20xx
    public enum Security: Int {
        case invalidSslCertificate = 2_001
    }
}
