//
//  PasswordValidator.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

/// Used for password validation logic
private extension CharacterSet {
  static let nonControlAsciiCharacters = CharacterSet(
    charactersIn: String(Array(33...126).map { Character(Unicode.Scalar($0)) })
  )
  static let asciiLetters = nonControlAsciiCharacters.intersection(CharacterSet.letters)
  static let asciiNumbers = nonControlAsciiCharacters.intersection(CharacterSet.decimalDigits)
  static let asciiSymbols = nonControlAsciiCharacters.intersection(asciiLetters.union(asciiNumbers).inverted)
}

/// Structure to keep track of rules followed by the input.
private enum PasswordRule: Int {
  case englishCharacters
  case numbers
  case allowedSymbols
}

/// Password validator based on rules required by your business:
/// - It should contain at least two of the following types:
///   - English characters
///   - Numbers
///   - Symbols (Any non-alphanumeric between ASCII 0033 and 0126)
/// - It should not contain space
/// - It should be between or including 8 - 32 characters
public struct PasswordValidator: ValidatorType {
  public enum Result {
    case empty
    case invalidLength
    case invalidFormat
    case needsVariation
    case valid
  }

  struct Constants {
    static let minPasswordLength = 8
    static let maxPasswordLength = 32
    static let minNumberOfPasswordRuleToFulfil = 2
  }

  public init() {}

  public func callAsFunction(_ input: String?) -> Result {
    guard let input = input, !input.isEmpty else { return .empty }

    let inputLength = input.unicodeScalars.count
    // Make sure the input length is within the boundaries
    guard Constants.minPasswordLength <= inputLength, inputLength <= Constants.maxPasswordLength else {
      return .invalidLength
    }

    var fulfilledPasswordRules = Set<PasswordRule>()
    // Run through each character and evaluate if they are within allowed character sets
    // Otherwise, bail early.
    for scalar in input.unicodeScalars {
      if CharacterSet.asciiNumbers.contains(scalar) {
        fulfilledPasswordRules.insert(.numbers)
      } else if CharacterSet.asciiLetters.contains(scalar) {
        fulfilledPasswordRules.insert(.englishCharacters)
      } else if CharacterSet.asciiSymbols.contains(scalar) {
        fulfilledPasswordRules.insert(.allowedSymbols)
      } else {
        // Disallowed character! Immediately return invalid format.
        return .invalidFormat
      }
    }

    // Make sure there are at least 2 password rules fulfilled.
    return fulfilledPasswordRules.count >= Constants.minNumberOfPasswordRuleToFulfil ? .valid : .needsVariation
  }
}
