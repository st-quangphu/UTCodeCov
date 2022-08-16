//
//  JapanesePostalCodeValidator.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

public struct JapanesePostalCodeValidator: ValidatorType {

  public init() {}

  public func callAsFunction(_ input: String?) -> Bool {
    guard let input = input else { return false }

    // Conform to the validation defined by the backend
    return input.range(of: #"^[0-9０-９]{3}[\-‑⁃–—―−ｰ﹣－ー]?[0-9０-９]{4}$"#, options: .regularExpression) != nil
  }
}
