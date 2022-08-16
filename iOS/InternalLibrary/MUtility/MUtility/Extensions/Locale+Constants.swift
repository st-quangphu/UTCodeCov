//
//  Locale+Constants.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public extension Locale {
    static let japan = Locale(identifier: "ja_JP")

    static var preferred: Locale {
        Locale.japan
    }
}
