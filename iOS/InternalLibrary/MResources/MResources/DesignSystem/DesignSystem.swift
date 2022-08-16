//
//  DesignSystem.swift
//  MResources
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation
/// This design system is used to replace current StyleGuide to provide a unified approach to config ui elements in the app.

public struct DesignSystem {
    public typealias Padding = Margin

    enum BrandColors {}

    /// Colors

    public struct Color {

        public enum Functional {}

        public enum Font {}

        public enum Icon {}
    }

    /// Fonts
    public enum Fonts {}

    public enum Margin {}

    public enum CornerRadius {}

    public enum BorderWidth {}

    public enum IconSize {}

    public struct Shadow {
        public let color: UIColor
        public let radius: CGFloat
        public let offset: CGSize
        public let opacity: Float
    }

    public enum ButtonSize {}
}

extension DesignSystem.BrandColors {

    public static let amber70 = UIColor(hex: 0xFFF3E4)
    public static let amber80 = UIColor(hex: 0xFAE0BF)
    public static let amber90 = UIColor(hex: 0xF5CD9B)
    public static let amber100 = UIColor(hex: 0xECA957)
    public static let amber110 = UIColor(hex: 0xE28718)
    public static let amber120 = UIColor(hex: 0xB25100)

    public static let black60 = UIColor(hex: 0x4E6780)
    public static let black70 = UIColor(hex: 0x375776)
    public static let black80 = UIColor(hex: 0x22496C)
    public static let black90 = UIColor(hex: 0x0A3359)
    public static let black100 = UIColor(hex: 0x002446)
    public static let black110 = UIColor(hex: 0x001A33)
    public static let black200 = UIColor(hex: 0x000000)

    public static let blue70 = UIColor(hex: 0xD7EEFD)
    public static let blue80 = UIColor(hex: 0xBCE2FB)
    public static let blue90 = UIColor(hex: 0x55B7FA)
    public static let blue100 = UIColor(hex: 0x24A0F2)
    public static let blue110 = UIColor(hex: 0x1D7DBD)
    public static let blue120 = UIColor(hex: 0x0E5687)

    public static let lavender80 = UIColor(hex: 0xE7EDF7)
    public static let lavender90 = UIColor(hex: 0xBCCBE7)
    public static let lavender100 = UIColor(hex: 0x95ABD7)
    public static let lavender110 = UIColor(hex: 0x5274B8)
    public static let lavender120 = UIColor(hex: 0x1F4798)
    public static let lavender130 = UIColor(hex: 0x002878)

    public static let red70 = UIColor(hex: 0xF7E7E8)
    public static let red80 = UIColor(hex: 0xFAB7BB)
    public static let red90 = UIColor(hex: 0xFA535F)
    public static let red100 = UIColor(hex: 0xEF303D)
    public static let red110 = UIColor(hex: 0xB30E1A)
    public static let red120 = UIColor(hex: 0x780008)

    public static let teal80 = UIColor(hex: 0xE7F7F6)
    public static let teal90 = UIColor(hex: 0xBCE7E4)
    public static let teal100 = UIColor(hex: 0x95D7D2)
    public static let teal110 = UIColor(hex: 0x52B8AF)
    public static let teal120 = UIColor(hex: 0x1F988E)
    public static let teal130 = UIColor(hex: 0x00786E)

    public static let violet80 = UIColor(hex: 0xECE7F7)
    public static let violet90 = UIColor(hex: 0xC8BCE7)
    public static let violet100 = UIColor(hex: 0xA795D7)
    public static let violet110 = UIColor(hex: 0x6D52B8)
    public static let violet120 = UIColor(hex: 0x3F1F98)
    public static let violet130 = UIColor(hex: 0x200078)

    public static let white50 = UIColor(hex: 0x5E7280)
    public static let white60 = UIColor(hex: 0x80939F)
    public static let white70 = UIColor(hex: 0xA6B5BF)
    public static let white80 = UIColor(hex: 0xD1D9DF)
    public static let white90 = UIColor(hex: 0xE7ECEF)
    public static let white100 = UIColor(hex: 0xFFFFFF)
}

extension DesignSystem.Color.Functional {
    typealias BrandColors = DesignSystem.BrandColors
    public typealias FunctionalColors = DesignSystem.Color.Functional

    // transparent is not in the figma
    public static let transparent = UIColor.clear
    public static let transparentActive = BrandColors.white80

    public static let primary = BrandColors.blue100
    public static let primaryActive = BrandColors.blue110

    public static let secondary = BrandColors.white60
    public static let secondaryActive = BrandColors.white50

    public static let disabled = BrandColors.white80
    public static var inactive: UIColor { FunctionalColors.disabled }

    public static let backgroundPrimary = BrandColors.white100
    public static let backgroundPrimaryActive = BrandColors.white90
    public static let backgroundSecondary = BrandColors.blue70

    public static let destructive = BrandColors.red110
    public static let destructiveActive = BrandColors.red90
    public static let destructiveFeedback = BrandColors.red70

    public static let tertiary = BrandColors.blue120
    public static let tertiaryActive = BrandColors.blue100

    public static let overlayWhite = BrandColors.white100
    public static let overlayBlack = BrandColors.black200
    public static let overlayAlert = BrandColors.black100
}

extension DesignSystem.Color.Icon {
    typealias BrandColors = DesignSystem.BrandColors

    public static let surface = BrandColors.black90
    public static let controlNormal = BrandColors.blue80
    public static let controlActivated = BrandColors.blue100
    public static let transaction = BrandColors.blue100
}

extension DesignSystem.Color.Font {
    typealias BrandColors = DesignSystem.BrandColors

    public static let primary = BrandColors.black100
    public static let secondary = BrandColors.black70

    public static let primaryLight = BrandColors.white100
    public static let secondaryLight = BrandColors.white90

    public static let affirmative = BrandColors.teal130
    public static let warning = BrandColors.amber120
    public static let destructive = BrandColors.red110
    public static let monthlyNotification = BrandColors.lavender110
    public static let disabled = BrandColors.white70

    public static let iconButton = BrandColors.black90
    public static let iconSpending = BrandColors.blue100
}

// iOS system font is SF Pro Display and Texš
extension DesignSystem.Fonts {
    public enum NotoSansJP: String {
        case black = "Black"
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case thin = "Thin"

        public var name: String {
            "NotoSansJP-".appending(self.rawValue)
        }

        public static func font(style: NotoSansJP, size: CGFloat) -> UIFont {
            UIFont(name: style.name, size: size) ?? .systemFont(ofSize: size)
        }
    }

    /// Return the sytem font by specified size
    /// - Parameter size: the size of font
    /// - Returns: the sytem font
    public static func systemFont(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }

    // Warning: Change the font-name, font-size by figma deign
    public static let h1 = NotoSansJP.font(style: .bold, size: 39)
    public static let h2 = NotoSansJP.font(style: .bold, size: 34)
    public static let h3 = NotoSansJP.font(style: .bold, size: 28)
    public static let h4 = NotoSansJP.font(style: .regular, size: 21)
    public static let h4Semibold = NotoSansJP.font(style: .bold, size: 21)
    public static let headline = NotoSansJP.font(style: .regular, size: 16)
    public static let body = NotoSansJP.font(style: .regular, size: 16)
    public static let subhead = NotoSansJP.font(style: .regular, size: 15)
    public static let caption1 = NotoSansJP.font(style: .regular, size: 15)
    public static let caption2 = NotoSansJP.font(style: .regular, size: 13)
}

extension DesignSystem.Margin {
    public static let extraSmall: CGFloat = 4.0
    public static let small: CGFloat = 8.0
    public static let standard: CGFloat = 12.0
    public static let large: CGFloat = 16.0
    public static let extraLarge: CGFloat = 24.0
    public static let extraExtraLarge: CGFloat = 32.0
}

extension DesignSystem.CornerRadius {
    public static let none: CGFloat = 0.0
    public static let standard: CGFloat = 4.0
    public static let medium: CGFloat = 5.0
    public static let large: CGFloat = 8.0
    public static let extraLarge: CGFloat = 10.0
}

extension DesignSystem.BorderWidth {
    public static let standard: CGFloat = 1.0
    public static let large: CGFloat = 5.0
}

extension DesignSystem.IconSize {
    public static let extraSmall: CGFloat = 16.0
    public static let small: CGFloat = 24.0
    public static let standard: CGFloat = 32.0
    public static let large: CGFloat = 40.0
}

extension DesignSystem.Shadow {
    public typealias Shadow = DesignSystem.Shadow
    public typealias CornerRadius = DesignSystem.CornerRadius
    public typealias BorderWidth = DesignSystem.BorderWidth

    public static let card = Shadow(
        color: DesignSystem.Color.Functional.overlayWhite,
        radius: CornerRadius.standard,
        offset: CGSize(width: 0, height: BorderWidth.standard),
        opacity: 0.08
    )
}

extension DesignSystem.ButtonSize {
    public static let small: CGFloat = 24.0
    public static let medium: CGFloat = 40.0
    public static let large: CGFloat = 48.0
}
