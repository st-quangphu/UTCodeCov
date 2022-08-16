//
//  Collection+SafeIndex.swift
//  MUtility
//
//  Created by MBP0003 on 2/7/22.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }

    public var isNotEmpty: Bool {
        !self.isEmpty
    }
}
