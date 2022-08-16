//
//  Int+toDate.swift
//  MUtility
//
//  Created by Long Vo M. on 7/15/22.
//

import Foundation


public extension Int {
    func toDate() -> Date {
        let unixTimestamp = Double(self / 1_000)
        return Date(timeIntervalSince1970: unixTimestamp)
    }
}
