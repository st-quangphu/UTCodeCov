//
//  UIBarButtonItem+DesignSystem.swift
//  MAResources
//
//  Created by MBP0003 on 8/9/21.
//

import Foundation
import UIKit

public extension UIBarButtonItem {

    struct Design {
        public let textColorNormal: UIColor
        public let textColorHighlighted: UIColor
        public let font: UIFont

        public static let standard = Design(
            textColorNormal: DesignSystem.Color.Functional.primary,
            textColorHighlighted: DesignSystem.Color.Functional.primary,
            font: DesignSystem.Fonts.subhead
        )

        /// Prepares a simple custom back button, based on the Back Arrow Icon
        public static func backButton() -> UIBarButtonItem {
            let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
//            backButton.image = Assets.Common.back.image
            return backButton
        }

        /// Prepares a simple custom close button, based on the Close Arrow Icon
        public static func closeButton() -> UIBarButtonItem {
            let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
//            backButton.image = Assets.Common.close.image
            return backButton
        }
    }

    func set(style: UIBarButtonItem.Design) {
        setTitleTextAttributes([.foregroundColor: style.textColorNormal, .font: style.font], for: .normal)
        setTitleTextAttributes([.foregroundColor: style.textColorHighlighted, .font: style.font], for: .highlighted)
    }
}
