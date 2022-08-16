//
//  Error+Code.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public extension Error {

    /// Type-casted pass-through of NSError.code
    var code: Int {
        (self as NSError).code
    }
}
