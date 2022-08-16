//
//  TimeInterval+DispatchTimeInterval.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public extension TimeInterval {

    func toDispatchTimeInterval() -> DispatchTimeInterval {
        DispatchTimeInterval.nanoseconds(Int(self * 1_000_000_000))
    }
}

public extension DispatchTimeInterval {
    func toTimeInterval() -> TimeInterval {
        switch self {
        case let .seconds(value):
            return TimeInterval(value)

        case let .milliseconds(value):
            return TimeInterval(value) / 1_000

        case let .microseconds(value):
            return TimeInterval(value) / 1_000_000

        case let .nanoseconds(value):
            return TimeInterval(value) / 1_000_000_000

        case .never:
            return TimeInterval(0)

        @unknown default:
            return TimeInterval(0)
        }
    }
}
