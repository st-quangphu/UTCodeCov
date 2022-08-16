//
//  ViewModelPageable.swift
//  MAUtility
//
//  Created by MBP0003 on 8/18/21.
//

import Foundation

public struct Page {
    public var offset: Int
    public var limit: Int

    public init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}

public protocol ViewModelPageable {
    var page: Page { get }
}
