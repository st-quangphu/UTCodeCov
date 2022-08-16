//
//  CharacterSet.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

public extension CharacterSet {
  static func asciiFullAndHalfWidth() -> CharacterSet {
    let ranges = [
      UnicodeRange.ascii.toUnicodeScalarRange(),
      UnicodeRange.asciiFullWidth.toUnicodeScalarRange()
    ].compactMap { $0 }
    var set = CharacterSet()
    for range in ranges { set.insert(charactersIn: range) }
    return set
  }

  static func kanji() -> CharacterSet {
    guard let range = UnicodeRange.kanji.toUnicodeScalarRange() else { return CharacterSet() }
    var set = CharacterSet()
    set.insert(charactersIn: range)
    return set
  }

  static func katakanaFullAndHalfWidth() -> CharacterSet {
    let ranges = [
      UnicodeRange.katakanaHalfWidth.toUnicodeScalarRange(),
      UnicodeRange.katakanaFullWidth.toUnicodeScalarRange()
    ].compactMap { $0 }
    var set = CharacterSet()
    for range in ranges { set.insert(charactersIn: range) }

    let kanaSymbolSet = CharacterSet(charactersIn: "‑⁃–—―−ｰ﹣－- 　")
    return set.union(kanaSymbolSet)
  }

  static func hiragana() -> CharacterSet {
    guard let range = UnicodeRange.hiragana.toUnicodeScalarRange() else { return CharacterSet() }
    var set = CharacterSet()
    set.insert(charactersIn: range)
    return set
  }
}
