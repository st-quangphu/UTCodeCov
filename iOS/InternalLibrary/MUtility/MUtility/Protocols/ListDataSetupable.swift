//
//  ListDataSetupable.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 7/25/22.
//

import Foundation

/// A protocol emphasizes the naming convention for provide data store for single table view or collection view
public protocol ListDataSetupable {

    /// The numbers of sections for each List Type
    /// - Returns: The numbers of sections
    func numberOfSections() -> Int

    /// The number of items in section
    /// - Parameters:
    ///   - section: provide the section index to retreive the number of items
    /// - Returns: The number of items in section
    func numberOfItems(in section: Int) -> Int

    /// The cell data at index path in List View
    /// - Parameters:
    ///   - indexPath: index of cell
    ///   - cellData: The Type that provide the data for sepcified cell, make sure it implement ViewData protocol
    /// - Returns: The cell data at index path in List View
    func cellForItem<T: ViewData>(at indexPath: IndexPath, cellData: T.Type) -> T?
}

public extension ListDataSetupable {
    func numberOfSections() -> Int {
        1
    }
}
