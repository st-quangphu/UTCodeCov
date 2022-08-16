//
//  SecurityError.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MResources

public final class SecurityError: MError {
    public enum Reason {
        case sslCertificatePinningFailed
    }

    public static func invalidSSLCertificate() -> SecurityError {
        SecurityError(
            errorType: .security,
            title: ResourceStrings.Common.Error.title,
            message: ResourceStrings.Error.SslCertificate.Alert.message,
            errorCode: ErrorCode.Security.invalidSslCertificate.rawValue
        )
    }
}
