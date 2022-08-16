//
//  OrderFoodCache.swift
//  MModels
//
//  Created by Quang Phu C. M. on 7/1/22.
//

import Foundation

// Define the prototype support cache data in memory
public protocol OrderFoodCacheType {
    var foods: [String] { get }

    func cacheFoods(_ foods: [String])
}

public class OrderFoodCache: OrderFoodCacheType {
    public var foods: [String] = []

    public init() {}

    public func cacheFoods(_ foods: [String]) {
        self.foods = foods
    }
}
