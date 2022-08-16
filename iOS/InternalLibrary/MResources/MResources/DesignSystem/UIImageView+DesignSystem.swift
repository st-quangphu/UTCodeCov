//
//  UIImageView+DesignSystem.swift
//  MAResources
//
//  Created by MBP0003 on 8/9/21.
//

import Foundation
import UIKit

public extension UIImageView {

    struct ImageViewDesign {
        public let imageAsset: ImageAsset?
        public let contentMode: ContentMode
        // This width has to be set manually to the view
        public let size: CGFloat
        public let tintColor: UIColor
        public let backgroundColor: UIColor?
        public let cornerRadius: CGFloat

        private init(
            imageAsset: ImageAsset? = nil,
            contentMode: ContentMode = .scaleAspectFit,
            size: CGFloat = DesignSystem.IconSize.standard,
            tintColor: UIColor = DesignSystem.Color.Icon.surface,
            backgroundColor: UIColor? = nil,
            cornerRadius: CGFloat = 0
        ) {
            self.imageAsset = imageAsset
            self.contentMode = contentMode
            self.size = size
            self.tintColor = tintColor
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
        }

        public static let extraSmall = ImageViewDesign(size: DesignSystem.IconSize.extraSmall)

        public static let small = ImageViewDesign(size: DesignSystem.IconSize.small)

        public static let standard = ImageViewDesign(size: DesignSystem.IconSize.standard)

        public static let large = ImageViewDesign(size: DesignSystem.IconSize.large)
    }

    func set(style: ImageViewDesign) {
        if let imageAsset = style.imageAsset {
            image = imageAsset.image
        }

        // Intentionally use built-in anchor to avoid having SnapKit dependency in this framework -- JLI 01/08/19
        translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = heightAnchor.constraint(equalToConstant: style.size)
        heightConstraint.priority = .required
        heightConstraint.isActive = true
        let widthConstraint = widthAnchor.constraint(equalTo: heightAnchor)
        widthConstraint.priority = .required
        widthConstraint.isActive = true

        contentMode = style.contentMode
        tintColor = style.tintColor
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
    }
}
