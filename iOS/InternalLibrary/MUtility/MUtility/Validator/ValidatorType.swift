//
//  ValidatorType.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

public protocol ValidatorType {
  associatedtype Input
  associatedtype ValidationResult
  func callAsFunction(_ input: Input) -> ValidationResult
}
