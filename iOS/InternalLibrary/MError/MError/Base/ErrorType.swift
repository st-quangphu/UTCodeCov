//
//  ErrorType.swift
//  MError
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation

public enum ErrorType: String, Equatable {
    // Generic
    case generic
    case unknown

    // API
    case request
    case response

    // Network
    case network
    case noNetworkConnection
    case networkTimeout

    // Server
    case server

    // Security
    case security

    // Data
    case decoding
    case encoding
    case parsing
    case filtering
    case sorting

    // Service
    case objectNotFound

    // Application
    case listIndexing

    // Keychain
    case keychain

    // Authentication
    case biometric
    case passcode

    // VOTP
    case votp

    // Database
    case databaseError
    case databaseCreate
    case databaseRead
    case databaseUpdate
    case databaseDelete
    case databaseObserve

    // Universal Link
    case universalLink
}
