//
//  VersionProvider.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public protocol VersionProviderType {
    var versionBuild: String { get }
}

public struct VersionProvider: VersionProviderType {

    // follow the same naming style as other system keys
    static let kCFBundleShortVersionKey = "CFBundleShortVersionString"

    public static var version: String {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleShortVersionKey) as! String
    }

    public static var build: String {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }

    public var versionBuild: String

    public init() {
        versionBuild = "\(VersionProvider.version) (\(VersionProvider.build))"
    }
}
