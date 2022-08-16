//
//  UIStackView+ArrangedSubviews.swift
//  MAUtility
//
//  Created by MBP0003 on 8/13/21.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }

    func removeAllArrangedSubviews() {
        // https://developer.apple.com/documentation/uikit/uistackview
        // Removing a view from the arrangedSubviews array does not remove it as a subview.
        // The stack view no longer manages the view’s size and position, but the view is still part of the view hierarchy, and is rendered on screen if it is visible.
        // From removeArrangedSubview method Signature:
        // To remove the view as a subview, send it -removeFromSuperview as usual; the relevant UIStackView will remove it from its arrangedSubviews list automatically.
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
