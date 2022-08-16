//
//  MError.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MResources

open class MError: Error {

    public static let genericTitle = ResourceStrings.Common.Error.title
    public static let genericMessage = ResourceStrings.Common.Error.genericMessage
    public static var logError: ((MError) -> Void)?

    public let errorType: ErrorType
    public let title: String?
    public let message: String?
    // Error code is String because some error codes from the server cannot be converted into Int
    // e.g. "DBS001"
    public let errorCode: String
    /// A place to dump the full JSON of a server error in case of needing to handle error objects that contain
    /// additional metadata, or that need to be handled more granularly than by HTTP status code.
    /// Note that we assume that the error object will always be a JSON dictionary.
    public let underlyingErrorJson: [String: Any]?

    public init(
        errorType: ErrorType = .generic,
        title: String? = MError.genericTitle,
        message: String? = MError.genericMessage,
        errorCode: String = String(ErrorCode.undefined.rawValue),
        underlyingErrorJson: [String: Any]? = nil
    ) {
        self.errorType = errorType
        self.title = title
        self.message = message
        self.errorCode = errorCode
        self.underlyingErrorJson = underlyingErrorJson

        // Whenever created a bcn error, forward itself to be logged
        MError.logError?(self)
    }

    public convenience init(
        errorType: ErrorType,
        title: String? = MError.genericTitle,
        message: String? = MError.genericMessage,
        errorCode: Int,
        underlyingErrorJson: [String: Any]? = nil
    ) {
        self.init(
            errorType: errorType,
            title: title,
            message: message,
            errorCode: String(errorCode),
            underlyingErrorJson: underlyingErrorJson
        )
    }

    public convenience init(error: Error) {
        self.init(
            errorType: ErrorType.unknown,
            title: MError.genericTitle,
            message: error.localizedDescription,
            errorCode: error._code,
            underlyingErrorJson: nil
        )
    }
}

// MARK: - CustomDebugStringConvertible

extension MError: CustomDebugStringConvertible {
    public var debugDescription: String {
        "MError(type: \(errorType), code: \(errorCode))"
    }
}

// MARK: - Equatable

extension MError: Equatable {
    public static func == (lhs: MError, rhs: MError) -> Bool {
        lhs.errorCode == rhs.errorCode
    }
}

// MARK: - Computed Properties

extension MError {

    public var isNetworkError: Bool {
        [.network, .networkTimeout, .noNetworkConnection].contains(errorType)
    }

    public var isServerError: Bool {
        errorType == .server && 500 ... 599 ~= Int(errorCode) ?? 0
    }

    public var isCertificatePinningError: Bool {
        errorCode == String(ErrorCode.Security.invalidSslCertificate.rawValue)
    }
}

// MARK: - MError+NSError

extension MError {
    public func toNSError() -> NSError {
        // not logging `underlyingErrorJson` purposely as it may contains PII
        return NSError(
            domain: errorType.rawValue,
            code: Int(errorCode) ?? -1,
            userInfo: [
                "title": title ?? "",
                "message": message ?? ""
            ]
        )
    }
}
