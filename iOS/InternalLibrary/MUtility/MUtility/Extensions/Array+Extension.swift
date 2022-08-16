//
//  Array+Extension.swift
//  MUtility
//
//  Created by Rin Sang on 03/08/2022.
//

import Foundation

public extension Array where Element: Equatable {

    /// Remove duplicates
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeDuplicates() -> ["h", "e", "o"]
    ///
    /// - Returns: self after removing duplicates instances of item.

    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self where !result.contains(value) {
            result.append(value)
        }

        return result
    }
}
