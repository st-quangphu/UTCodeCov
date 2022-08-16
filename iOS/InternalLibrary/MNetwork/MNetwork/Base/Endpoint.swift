//
//  Endpoint.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MUtility

/// The protocol used to define the specifications necessary for a `Endpoint` class.
public protocol Endpoint {

    var server: APIServer { get }

    var version: String { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request. Default is `.get`.
    var method: HttpMethod { get }

    var timeout: Double { get }

    /// The type of HTTP task to be performed. Default is `.requestPlain`.
    var requestType: RequestType { get }

    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType { get }

    /// The extra headers to be used in the request. Default is `[:]`.
    var headers: [String: String] { get }

    /// The decoder for response parsing, JSON Decoder is not over-written
    var responseDecoder: AnyDecoder { get }

    /// Custom URL provider. When it returns a value, it will be used for the network request.
    /// Otherwise, it will use default under-the-hood URL constructor (using `server`, `path` and `NetworkEnvironment`).
    /// Defaults to `nil`.
    var customURL: URL? { get }

    var fullPath: String { get }

    /// Whether errors related to this endpoint are shown to the end user or not.
    var showsErrorsToGuest: Bool { get }
}

// MARK: - Defaults

public extension Endpoint {

    var validationType: ValidationType {
        .successCodes
    }

    var version: String {
        ""
    }

    var method: HttpMethod {
        .get
    }

    var timeout: Double {
        10
    }

    var requestType: RequestType {
        .requestPlain
    }

    var headers: [String: String] {
        [:]
    }

    var responseDecoder: AnyDecoder {
        JSONDecoder.decoder()
    }

    var customURL: URL? { nil }

    var fullPath: String {
        server.rawValue + path
    }

    var showsErrorsToGuest: Bool {
        switch method {
        case .get: return false
        default: return true
        }
    }
}
