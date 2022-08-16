//
//  Platform.swift
//  MAUtility
//
//  Created by MBP0003 on 8/13/21.
//

import Foundation

public class Platform {

    /// Helper to allow `#available(...)` checks in the ternary operator.
    ///
    /// - Note: you still need to use `if #available` if you're accessing APIs that are marked with `@available(...)`
    ///   as the compiler can't verify that using this method is equivalent, therefore use of this should be limited
    ///   to dealing with simple cases like minor style differences when a control changes between versions, e.g.
    ///   UISegmentedControl.
    public static var ios13: Bool {
        if #available(iOS 13.0, *) {
            return true
        } else {
            return false
        }
    }
}
