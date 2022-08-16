//
//  ViewDataLoadable.swift
//  MAUtility
//
//  Created by MBP0003 on 8/9/21.
//

import Foundation

/// A protocol emphasizes the naming convention for view data loading
public protocol ViewDataLoadable {
    associatedtype ViewData

    func loadData(_ viewData: ViewData?)
}
