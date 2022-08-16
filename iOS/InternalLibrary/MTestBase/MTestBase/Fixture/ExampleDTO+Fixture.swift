//
//  ExampleDTO+Fixture.swift
//  MTestBase
//
//  Created by Quang Phu C. M. on 7/1/22.
//

import Foundation
import MModels
import MUtility

// Didn't use plain text json file as it is too easy to be extracted from IPA
// As this may used in the app for development or demo purpose.
// swiftlint:disable force_try
extension ExampleDTO {
    public static let getFixtureData = """
  {
    "id": 1,
    "name": "ABC",
    "hobies": ["Swimming", "Running"]
  }
  """.data(using: .utf8)!

    public static let getFixtureObject: ExampleDTO = try! getFixtureData.decoded()
}
