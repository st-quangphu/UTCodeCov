//
//  UIStackView+DesignSystem.swift
//  MAResources
//
//  Created by MBP0003 on 8/13/21.
//

import Foundation
import UIKit

public extension UIStackView {

    struct StackViewDesign {
        public let axis: NSLayoutConstraint.Axis
        public let distribution: UIStackView.Distribution
        public let alignment: UIStackView.Alignment
        public let spacing: CGFloat?

        // Use the fillProportionally as it works best with a fixed spacing
        // https://developer.apple.com/documentation/uikit/uistackview/1616225-spacing
        private init(
            axis: NSLayoutConstraint.Axis = .horizontal,
            distribution: UIStackView.Distribution = .fill,
            alignment: UIStackView.Alignment = .fill,
            spacing: CGFloat? = nil
        ) {
            self.axis = axis
            self.distribution = distribution
            self.alignment = alignment
            self.spacing = spacing
        }

        public static let vertical = StackViewDesign(axis: .vertical, spacing: DesignSystem.Padding.extraSmall)
        public static let horizontal = StackViewDesign(spacing: DesignSystem.Padding.small)
        public static let horizontalButtons = StackViewDesign(
            distribution: .fillEqually,
            spacing: DesignSystem.Padding.small
        )
    }

    func set(style: StackViewDesign) {
        axis = style.axis
        distribution = style.distribution
        alignment = style.alignment
        if let spacing = style.spacing {
            self.spacing = spacing
        }
    }
}
