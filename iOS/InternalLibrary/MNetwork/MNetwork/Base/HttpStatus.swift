//
//  HttpStatus.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

// https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html

// enum HttpStatus is a namespace
public enum HttpStatus {}

// MARK: - HttpStatus.Group

public extension HttpStatus {

    @objc
    enum Group: Int {
        case unknown
        case informational
        case successful
        case redirection
        case clientError
        case serverError

        public var isError: Bool {
            switch self {
            case .clientError, .serverError:
                return true

            default:
                return false
            }
        }
    }
}

// MARK: - HttpStatus.Code

public extension HttpStatus {

    @objc
    enum Code: Int {

        // MARK: 100 Informational

        case `continue` = 100
        case switchingProtocols = 101
        case processing = 102

        // MARK: 200 Success

        case ok = 200
        case created = 201
        case accepted = 202
        case nonAuthoritativeInformation = 203
        case noContent = 204
        case resetContent = 205
        case partialContent = 206
        case multiStatus = 207
        case alreadyReported = 208
        case iMUsed = 226

        // MARK: 300 Redirection

        case multipleChoices = 300
        case movedPermanently = 301
        case found = 302
        case seeOther = 303
        case notModified = 304
        case useProxy = 305
        case unused = 306
        case temporaryRedirect = 307
        case permanentRedirect = 308

        // MARK: 400 Client Error

        case badRequest = 400
        case unauthorized = 401
        case paymentRequired = 402
        case forbidden = 403
        case notFound = 404
        case methodNotAllowed = 405
        case notAcceptable = 406
        case proxyAuthenticationRequired = 407
        case requestTimeout = 408
        case conflict = 409
        case gone = 410
        case lengthRequired = 411
        case preconditionFailed = 412
        case payloadTooLarge = 413
        case uriTooLong = 414
        case unsupportedMediaType = 415
        case rangeNotSatisfiable = 416
        case expectationFailed = 417
        case imATeapot = 418
        case misdirectedRequest = 421
        case unprocessableEntity = 422
        case locked = 423
        case failedDependency = 424
        case upgradeRequired = 426
        case preconditionRequired = 428
        case tooManyRequests = 429
        case requestHeaderFieldsTooLarge = 431
        case unavailableForLegalReasons = 451

        // MARK: 500 Server Error

        case internalServerError = 500
        case notImplemented = 501
        case badGateway = 502
        case serviceUnavailable = 503
        case gatewayTimeout = 504
        case httpVersionNotSupported = 505
        case variantAlsoNegotiates = 506
        case insufficientStorage = 507
        case loopDetected = 508
        case notExtended = 510
        case networkAuthenticationRequired = 511

        public var group: Group { rawValue.group }

        public var isError: Bool { group.isError }

        public var stringValue: String {
            String(rawValue)
        }
    }
}

// MARK: - Int+Group

public extension Int {
    private typealias Group = HttpStatus.Group

    var code: HttpStatus.Code? {
        HttpStatus.Code(rawValue: self)
    }

    var group: HttpStatus.Group {
        switch self {
        case 100 ... 199:
            return .informational

        case 200 ... 299:
            return .successful

        case 300 ... 399:
            return .redirection

        case 400 ... 499:
            return .clientError

        case 500 ... 599:
            return .serverError

        default:
            return .unknown
        }
    }
}
