//
//  Decoding.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

// MARK: - Make `decoder` default
extension JSONDecoder {

    public static func decoder(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .customISO8601
    )
    -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return decoder
    }
}

// Mainly borrowed from https://www.swiftbysundell.com/posts/type-inference-powered-serialization-in-swift

extension Data {

    public func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder.decoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
}

public protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder {}
extension PropertyListDecoder: AnyDecoder {}

public extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let dateString = try container.decode(String.self)

        // TODO: - This approach falls back to date format without fractional seconds
        // if fails to decode with fullInternetDateAndTime
        // Needs to be modified once we have agreement with backend on the date format
        if
            let date = ISO8601DateFormatter(dataFormat: .fullInternetDateAndTime).date(from: dateString)
                ?? ISO8601DateFormatter(dataFormat: .internetDateAndTime).date(from: dateString)
        {
            return date
        }

        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(dateString)")
    }
}
