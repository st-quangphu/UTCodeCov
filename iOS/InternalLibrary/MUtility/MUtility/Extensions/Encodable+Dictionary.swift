//
//  Encodable+Dictionary.swift.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

extension Encodable {
    // This method convert any encodable classes/structs into a snake-case dictionary
    // refer to `RequestType` for how this method is used
    public func asDictionary(using encoder: JSONEncoder = JSONEncoder.encoder()) -> [String: Any]? {
        guard let data = try? encoder.encode(self) else {
            return nil
        }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}

extension JSONEncoder {
    public static func encoder(_ keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase)
    -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy
        return encoder
    }
}
