//
//  UnicodeRange.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

/// Definitions for ranges defining unicode code-point values for blocks used within the project
public enum UnicodeRange {
  /// Basic Latin - [Reference](https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block))
  static let ascii = 0x0000...0x007F

  /// Basic Latin - [Reference](https://en.wikipedia.org/wiki/Halfwidth_and_Fullwidth_Forms_(Unicode_block))
  static let asciiFullWidth = 0xFF00...0xFF5E

  /// Hiragana - [Reference](https://en.wikipedia.org/wiki/Hiragana_(Unicode_block))
  static let hiragana = 0x3041...0x309f

  /// Kanji - [Reference](https://www.unicode.org/charts/PDF/U4E00.pdf)
  static let kanji = 0x4E00...0x9FBF

  /// Katakana Full-Width - [Reference](https://www.unicode.org/charts/PDF/U30A0.pdf)
  /// Requirement: https://moneytree-app.atlassian.net/browse/BCN-3316
  static let katakanaFullWidth = 0x30A0...0x30FF

  /// Katakana Half-Width - [Reference](https://en.wikipedia.org/wiki/Halfwidth_and_Fullwidth_Forms_(Unicode_block))
  /// Requirement: https://moneytree-app.atlassian.net/browse/BCN-3316
  static let katakanaHalfWidth = 0xFF66...0xFF9F
}
