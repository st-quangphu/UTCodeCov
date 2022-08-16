//
//  HttpHeaderKeyType.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import MUtility

// MARK: - HttpHeaderKeyType

public protocol HttpHeaderKeyType {
    static var key: String { get }
}

// MARK: - HttpHeaderKey

public struct HttpHeader {

    public struct AcceptLanguage: HttpHeaderKeyType {
        public static let key = "Accept-Language"
    }

    public struct ApiKey: HttpHeaderKeyType {
        public static let key = "X-Api-Key"
    }

    public struct ContentType: HttpHeaderKeyType {
        public static let key = "Content-Type"
        static let jsonValue = "application/json"
        static let formEncodedValue = "application/x-www-form-urlencoded"
    }

    public struct Accept: HttpHeaderKeyType {
        public static let key = "Accept"
        static let value = "application/json"
    }

    public struct Authorization: HttpHeaderKeyType {
        public static let key = "Authorization"
        static let valuePrefixBearer = "Bearer"

        static func valueBasic(clientId: String) -> String { "Basic ..." }
    }

    public struct Location: HttpHeaderKeyType {
        public static let key = "Location"
    }

//    public struct ApiVersion: HttpHeaderKeyType {
//        public static let key = "X-Api-Ver"
//        public static let value = "\(ApiClient.API_VERSION)"
//    }

    public struct AppVersion: HttpHeaderKeyType {
        public static let key = "X-App-Ver"
        public static let value = VersionProvider.version
    }

    public struct AppOS: HttpHeaderKeyType {
        public static let key = "X-App-Os"
        public static let value = "iOS"
    }
}
