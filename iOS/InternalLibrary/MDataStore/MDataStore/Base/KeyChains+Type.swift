//
//  Keychain+KeychainType.swift
//  MService
//
//  Created by Quang Phu C. M. on 7/1/22.
//

import Foundation
import KeychainAccess
import LocalAuthentication

public protocol KeychainType {
    func get(_ key: String) throws -> String?
    func getData(_ key: String) throws -> Data?
    func getString(_ key: String) throws -> String?
    func removeAll() throws
    func set(_ value: Data, key: String) throws
    func set(_ value: String, key: String) throws
}


extension KeychainAccess.Keychain: KeychainType {
    public func get(_ key: String) throws -> String? {
        try get(key, ignoringAttributeSynchronizable: true)
    }

    public func getData(_ key: String) throws -> Data? {
        try getData(key, ignoringAttributeSynchronizable: true)
    }

    public func getString(_ key: String) throws -> String? {
        try getString(key, ignoringAttributeSynchronizable: true)
    }

    public func set(_ value: Data, key: String) throws {
        try set(value, key: key, ignoringAttributeSynchronizable: true)
    }

    public func set(_ value: String, key: String) throws {
        try set(value, key: key, ignoringAttributeSynchronizable: true)
    }
}
