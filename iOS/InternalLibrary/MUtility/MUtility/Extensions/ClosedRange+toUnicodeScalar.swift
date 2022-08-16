//
//  ClosedRange+toUnicodeScalar.swift
//  MUtility
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation

public extension ClosedRange where Element == Int {
  private var hexDescription: String {
    "ClosedRange(\(String(format: "0x%04X", lowerBound)) → \(String(format: "0x%04X", upperBound)))"
  }

  func toUnicodeScalarRange() -> ClosedRange<UnicodeScalar>? {
    guard
      let lower = Unicode.Scalar(lowerBound),
      let upper = Unicode.Scalar(upperBound)
    else {
      Log.warning("Failed to initialize Unicode scalar range from: \(hexDescription)")
      return nil
    }

    return lower...upper
  }
}
