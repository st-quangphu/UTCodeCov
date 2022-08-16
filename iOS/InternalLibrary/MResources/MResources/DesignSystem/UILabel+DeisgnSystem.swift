//
//  UILabel+DeisgnSystem.swift
//  MAResources
//
//  Created by MBP0003 on 8/10/21.
//

import Foundation
import UIKit

public extension UILabel {

    /// Definition of the font and textColor combination to be used by the label
    struct LabelDesign {
        public let font: UIFont
        public let textColor: UIColor

        /// Constructor
        ///
        /// - Parameters:
        ///   - font: Font to be used by the label
        ///   - textColor: Text color. Default = Black
        private init(font: UIFont, textColor: UIColor = DesignSystem.Color.Font.primary) {
            self.font = font
            self.textColor = textColor
        }

        public static let h1 = LabelDesign(font: DesignSystem.Fonts.h1)
        public static let h2 = LabelDesign(font: DesignSystem.Fonts.h2)
        public static let h3 = LabelDesign(font: DesignSystem.Fonts.h3)
        public static let h4 = LabelDesign(font: DesignSystem.Fonts.h4)
        public static let h4Semibold = LabelDesign(font: DesignSystem.Fonts.h4Semibold)
        public static let headline = LabelDesign(font: DesignSystem.Fonts.headline)
        public static let body = LabelDesign(font: DesignSystem.Fonts.body)
        public static let subhead = LabelDesign(font: DesignSystem.Fonts.subhead)
        public static let caption1 = LabelDesign(font: DesignSystem.Fonts.caption1)
        public static let caption2 = LabelDesign(font: DesignSystem.Fonts.caption2)
    }

    /// Sets up the label with the specified style and other default settings
    ///
    /// Other than style (font and text color) also sets defaults for:
    /// `adjustsFontForContentSizeCategory`, `accessibilityIdentifier` and `numberOfLines`
    ///
    /// - Parameter style: A pre-defined style definition to be used by the label
    /// - Parameter numberOfLines: Maximum number of lines for the label, default to no limit
    func set(style: LabelDesign, numberOfLines: Int = 0) {
        font = style.font
        textColor = style.textColor
        adjustsFontForContentSizeCategory = true
        accessibilityIdentifier = String(describing: type(of: self))
        self.numberOfLines = numberOfLines
    }
}
