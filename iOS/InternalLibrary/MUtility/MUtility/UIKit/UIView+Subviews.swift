//
//  UIView+Subviews.swift
//  MAUtility
//
//  Created by MBP0003 on 8/9/21.
//

import Foundation
import UIKit

/// This convenience extension allows us to more concisely express view hierarchies.
/// Note that this only allows one level, rather than a full hierarchy.
public extension UIView {
    /// Add multiple subviews to a view.
    ///
    /// - Parameter views: The views to be added.
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

    func removeAllSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
