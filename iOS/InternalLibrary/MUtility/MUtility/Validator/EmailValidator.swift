//
//  EmailValidator.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

/// Email validator based on RFC 5322 and rules required by your business:
/// - It should only contain English characters, numbers and symbols.
/// - It should contain only one `@`
/// - It should contain more than one `.` after `@`
/// - It should not contain white space neither before `@`, nor after `@`
/// - It should limit to <= 100 characters
public struct EmailValidator: ValidatorType {
  public enum Result {
    case empty
    case invalidFormat
    case invalidLength
    case valid
  }

  struct Constants {
    static let maxCharactersCount = 100
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  }

  public init() {}

  public func callAsFunction(_ input: String?) -> Result {
    // Nil input is "valid".
    guard let input = input, !input.isEmpty else { return .empty }

    // Make sure input is <= 100
    guard input.count <= Constants.maxCharactersCount else { return .invalidLength }

    return NSPredicate(format: "SELF MATCHES %@", Constants.emailRegex).evaluate(with: input) ? .valid : .invalidFormat
  }
}
