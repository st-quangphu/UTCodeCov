//
//  KatakanaValidator.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation


public struct KatakanaValidator: ValidatorType {

  private let characterSet = CharacterSet.katakanaFullAndHalfWidth()

  public init() {}

  public func callAsFunction(_ input: String?) -> Bool {
    guard let input = input else { return false }
    return input.unicodeScalars.allSatisfy { characterSet.contains($0) }
  }
}
