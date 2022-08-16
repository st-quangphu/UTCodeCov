//
//  UIButton+DesignSystem.swift
//  MAResources
//
//  Created by MBP0003 on 8/13/21.
//

import UIKit

public extension UIButton {

    struct ButtonDesign {
        public let font: UIFont

        // The foreground includes text and images.
        public let foregroundColor: UIColor
        public let highlightForegroundColor: UIColor
        public let disabledForegroundColor: UIColor

        public let backgroundColor: UIColor
        public let highlightBackgroundColor: UIColor
        public let disabledBackgroundColor: UIColor

        public let borderWidth: CGFloat?
        public let borderColor: UIColor?

        public let cornerRadius: CGFloat
        public let buttonHeight: CGFloat

        public let imageAsset: ImageAsset?
        public let imageSize: CGFloat?
        public let imageToTextMargin: CGFloat?
        public let forceImageToRightEdge: Bool

        private init(
            font: UIFont = DesignSystem.Fonts.headline,
            foregroundColor: UIColor,
            highlightForegroundColor: UIColor? = nil, // Defaults to `foregroundColor`
            disabledForegroundColor: UIColor = DesignSystem.Color.Font.disabled,
            backgroundColor: UIColor,
            highlightBackgroundColor: UIColor? = nil, // Defaults to `backgroundColor`
            disabledBackgroundColor: UIColor = DesignSystem.Color.Functional.disabled,
            borderWidth: CGFloat? = nil,
            borderColor: UIColor? = nil,
            cornerRadius: CGFloat = DesignSystem.ButtonSize.large / 2,
            buttonHeight: CGFloat = DesignSystem.ButtonSize.large,
            imageAsset: ImageAsset? = nil,
            imageSize: CGFloat? = nil,
            imageToTextMargin: CGFloat? = nil,
            forceImageToRightEdge: Bool = false
        ) {
            self.font = font

            self.foregroundColor = foregroundColor
            self.highlightForegroundColor = highlightForegroundColor ?? foregroundColor
            self.disabledForegroundColor = disabledForegroundColor

            self.backgroundColor = backgroundColor
            self.highlightBackgroundColor = highlightBackgroundColor ?? backgroundColor
            self.disabledBackgroundColor = disabledBackgroundColor

            self.borderWidth = borderWidth
            self.borderColor = borderColor

            self.cornerRadius = cornerRadius
            self.buttonHeight = buttonHeight

            self.imageAsset = imageAsset
            self.imageSize = imageSize
            self.imageToTextMargin = imageToTextMargin
            self.forceImageToRightEdge = forceImageToRightEdge
        }

        public static let primary = ButtonDesign(
            foregroundColor: DesignSystem.Color.Font.primaryLight,
            backgroundColor: DesignSystem.Color.Functional.primary,
            highlightBackgroundColor: DesignSystem.Color.Functional.primaryActive
        )

        public static let secondary = ButtonDesign(
            foregroundColor: DesignSystem.Color.Font.primaryLight,
            backgroundColor: DesignSystem.Color.Functional.secondary,
            highlightBackgroundColor: DesignSystem.Color.Functional.secondaryActive
        )

        public static let tertiary = makeTertiary(margin: DesignSystem.Margin.small)

        public static let tertiaryWithoutDisclosure = makeTertiary(
            margin: DesignSystem.Margin.small,
            disclosureIndicator: false
        )

        public static let largeTertiary = makeTertiary(margin: DesignSystem.Margin.large)

        public static let largeTertiaryWithSubhead = makeTertiary(
            margin: DesignSystem.Margin.large,
            font: DesignSystem.Fonts.subhead
        )

        public static let largeTertiaryDestructive = makeTertiary(margin: DesignSystem.Margin.large, destructive: true)

        public static let actionSheet = ButtonDesign(
            font: DesignSystem.Fonts.body,
            foregroundColor: DesignSystem.Color.Functional.primary,
            highlightForegroundColor: DesignSystem.Color.Functional.primaryActive,
            backgroundColor: DesignSystem.Color.Functional.backgroundPrimary,
            highlightBackgroundColor: DesignSystem.Color.Functional.backgroundPrimary
        )

        public static let link = ButtonDesign(
            foregroundColor: DesignSystem.Color.Font.affirmative,
            backgroundColor: DesignSystem.Color.Functional.transparent,
            cornerRadius: 0
        )

        public static let mediumPrimary = ButtonDesign(
            foregroundColor: DesignSystem.Color.Font.primaryLight,
            backgroundColor: DesignSystem.Color.Functional.primary,
            highlightBackgroundColor: DesignSystem.Color.Functional.primaryActive,
            cornerRadius: DesignSystem.ButtonSize.medium / 2,
            buttonHeight: DesignSystem.ButtonSize.medium
        )

        private static func makeTertiary(
            margin: CGFloat,
            font: UIFont = DesignSystem.Fonts.body,
            disclosureIndicator: Bool = true,
            destructive: Bool = false
        ) -> ButtonDesign {
            let primaryColor = destructive ?
                DesignSystem.Color.Functional.destructive : DesignSystem.Color.Functional.tertiary

            let activeColor: UIColor
            if destructive {
                activeColor = DesignSystem.Color.Functional.destructiveActive
            } else if !disclosureIndicator {
                // Currently used as the PFM root expand/collapse button.
                activeColor = primaryColor
            } else {
                activeColor = DesignSystem.Color.Functional.tertiaryActive
            }

            let highlightBackgroundColor = disclosureIndicator
                ? DesignSystem.Color.Functional.transparent
                : DesignSystem.Color.Functional.backgroundPrimaryActive
            return ButtonDesign(
                font: font,
                foregroundColor: primaryColor,
                highlightForegroundColor: activeColor,
                backgroundColor: DesignSystem.Color.Functional.transparent,
                highlightBackgroundColor: highlightBackgroundColor,
                disabledBackgroundColor: DesignSystem.Color.Functional.transparent,
                cornerRadius: 0,
                imageAsset: disclosureIndicator ? Assets.Onboarding.splash : nil,
                imageToTextMargin: margin,
                forceImageToRightEdge: true
            )
        }
    }

    func set(style: ButtonDesign) {
        // NOTE: We do _not_ use `tintColor` for our buttons, because we need to set custom colors for different states,
        // which `tintColor` breaks.
        titleLabel?.font = style.font
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.textAlignment = .center

        setTitleColor(style.foregroundColor, for: .normal)
        setTitleColor(style.highlightForegroundColor, for: .highlighted)
        setTitleColor(style.disabledForegroundColor, for: .disabled)

        setBackgroundColor(style.backgroundColor, for: .normal)
        setBackgroundColor(style.highlightBackgroundColor, for: .highlighted)
        setBackgroundColor(style.disabledBackgroundColor, for: .disabled)

        layer.cornerRadius = style.cornerRadius
        if let borderWidth = style.borderWidth {
            layer.borderWidth = borderWidth
        }
        if let borderColor = style.borderColor {
            layer.borderColor = borderColor.cgColor
        }

        if let imageAsset = style.imageAsset {
            let image: UIImage?
            if let imageSize = style.imageSize {
                // TODO: Scale size to match text size in accessibility, BCN-2194 AWE 2020/03/04
                image = imageAsset.image.scaledToSize(CGSize(width: imageSize, height: imageSize))
            } else {
                image = imageAsset.image
            }

            if let image = image {
                setImage(image, color: style.foregroundColor, for: .normal)
                setImage(image, color: style.highlightForegroundColor, for: .highlighted)
                setImage(image, color: style.disabledForegroundColor, for: .disabled)
            }

            let margin = style.imageToTextMargin ?? DesignSystem.Margin.small
            if style.forceImageToRightEdge {
                // For button Intrinsic content size calculation we should apply margin to contentEdgeInsets
                // https://stackoverflow.com/questions/17800288/autolayout-intrinsic-size-of-uibutton-does-not-include-title-insets
                // https://github.com/mt-bcn/bcn-app-ios/pull/404#issuecomment-575449065
                semanticContentAttribute = .forceRightToLeft
                imageEdgeInsets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: -margin)
                contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: margin)
            } else {
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -margin, bottom: 0, right: margin)
                contentEdgeInsets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: 0)
            }
        }

        // To make sure content still sits inside the rounded rect.
        if !style.cornerRadius.isZero {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: style.cornerRadius, bottom: 0, right: style.cornerRadius)
        }

        layer.masksToBounds = true
        accessibilityIdentifier = String(describing: type(of: self))

        // Intentionally use built-in anchor to avoid having SnapKit dependency in this framework -- JLI 01/08/19
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: style.buttonHeight).isActive = true
    }
}

// MARK: - UIKit Extensions

// Theoretically This extension should live in UIComponents lib as an public extension,
// however, as this framework is a dependency of the UIComponents,
// and also this extension is not been used in any other places at the moment,
// I decided to keep the scope minimum -- JLI 13/09/19
// https://stackoverflow.com/questions/14523348/how-to-change-the-background-color-of-a-uibutton-while-its-highlighted
private extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    /// Set a custom background color for a specific control state.
    /// - Parameters:
    ///   - color: The background color.
    ///   - state: The control state that the background color should be shown for.
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(image(withColor: color), for: state)
    }

    /// Set an image and its appropriate tint color for a specific control state.
    /// - Parameters:
    ///   - image: The image to display.
    ///   - color: The color the image should be tinted.
    ///   - state: The control state that the image should be shown for.
    func setImage(_ image: UIImage, color: UIColor, for state: UIControl.State) {
        if #available(iOS 13.0, *) {
            setImage(image.withTintColor(color, renderingMode: .alwaysOriginal), for: state)
        } else {
            setImage(image.maskWithColor(color), for: state)
        }
    }
}

private extension UIImage {
    /// This is a substitute for image.withTintColor which is only available from iOS 13.0.
    /// Solution hijacked from https://stackoverflow.com/questions/31803157/how-can-i-color-a-uiimage-in-swift
    func maskWithColor(_ color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

// swiftlint:enable file_length
