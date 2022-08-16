//
//  String + Html.swift
//  MUtility
//
//  Created by Duong Nguyen T. on 3/30/22.
//

import Foundation

public extension String {
    func htmlAttributed(fontName: String, fontSize: CGFloat, textAlign: NSTextAlignment) -> NSAttributedString? {
        // swiftlint:disable explicit_init line_length
        let modifiedFont = Self.init(format: "<span style=\"font-family: '\(fontName)'; font-size: \(fontSize);\">%@</span>", self)

        guard let data = modifiedFont.data(using: .unicode, allowLossyConversion: true) else {
            return nil
        }

        let style = NSMutableParagraphStyle()
        style.alignment = textAlign

        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],

            documentAttributes: nil) else { return nil }
        html.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: html.length))

        return html
    }
}
