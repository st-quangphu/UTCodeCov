//
//  UITableView+RegisterCell.swift
//  MAUtility
//
//  Created by MBP0003 on 8/11/21.
//

import Foundation
import UIKit

public extension UITableView {
    /// An utility method to register a cell class by its class name
    /// Caution: The cellClass should not be optional as the `String(describing: cellClass)` produce different string on optional/non-optional types
    /// - Parameter cellClass: cell class
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<CellClass>(withCellType cellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        // Force casting purposely in order to know something wrong straight away
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! CellClass
    }

    /// A utility method to register a table header / footer class by its class name
    /// - Warning: The headerFooterClass should not be optional as the `String(describing: cellClass)`
    /// produce different string on optional/non-optional types
    /// - Parameter headerFooterClass: table view header or footer class
    func registerHeaderFooter(_ headerFooterClass: AnyClass) {
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterClass))
    }

    func dequeueHeaderFooter<HeaderFooterClass>(withType classType: HeaderFooterClass.Type) -> HeaderFooterClass {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: classType)) as! HeaderFooterClass
    }
}
