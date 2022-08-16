//
//  MultiListDataSetupable.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 7/25/22.
//

import Foundation

/// A protocol emphasizes the naming convention for provide data store for multiple table view or collection view
public protocol MultiListDataSetupable {
    associatedtype ListType

    /// The numbers of sections for each List Type
    /// - Parameter type: List view classification
    /// - Returns: The numbers of sections
    func numberOfSections(type: ListType) -> Int

    /// The number of items in section
    /// - Parameters:
    ///   - type: List view classification
    ///   - section: provide the section index to retreive the number of items
    /// - Returns: The number of items in section
    func numberOfItems(type: ListType, in section: Int) -> Int

    /// The cell data at index path in List View
    /// - Parameters:
    ///   - type: List view classification
    ///   - indexPath: index of cell
    ///   - cellData: The Type that provide the data for sepcified cell, make sure it implement ViewData protocol
    /// - Returns: The cell data at index path in List View
    func cellForItem<T: ViewData>(type: ListType, at indexPath: IndexPath, cellData: T.Type) -> T?
}

public extension MultiListDataSetupable {
    func numberOfSections(type: ListType) -> Int {
        1
    }
}
