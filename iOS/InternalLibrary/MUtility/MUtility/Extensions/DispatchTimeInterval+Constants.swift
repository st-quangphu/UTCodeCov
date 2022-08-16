//
//  DispatchTimeInterval+Constants.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public extension DispatchTimeInterval {
    static let immediate = DispatchTimeInterval.seconds(0)

    static func minutes(_ minutes: Int) -> DispatchTimeInterval {
        .seconds(minutes * 60)
    }

    static func hours(_ hours: Int) -> DispatchTimeInterval {
        .minutes(hours * 60)
    }

    static func days(_ days: Int) -> DispatchTimeInterval {
        .hours(days * 24)
    }
}
