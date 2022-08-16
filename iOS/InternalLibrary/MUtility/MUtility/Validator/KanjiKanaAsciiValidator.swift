//
//  KanjiKanaAsciiValidator.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

/// Validates strings to contain only Kanji, Kana (which includes Katakana & Hiragana) and/or Ascii characters.
public struct KanjiKanaAsciiValidator: ValidatorType {

  private let characterSet: CharacterSet = {
    var set = CharacterSet()
    set.formUnion(CharacterSet.asciiFullAndHalfWidth())
    set.formUnion(CharacterSet.kanji())
    set.formUnion(CharacterSet.katakanaFullAndHalfWidth())
    set.formUnion(CharacterSet.hiragana())
    return set
  }()

  public init() {}

  public func callAsFunction(_ input: String?) -> Bool {
    guard let input = input else { return false }
    return input.unicodeScalars.allSatisfy { characterSet.contains($0) }
  }
}
