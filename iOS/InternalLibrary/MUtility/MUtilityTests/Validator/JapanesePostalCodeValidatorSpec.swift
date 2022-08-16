//
//  JapanesePostalCodeValidatorSpec.swift
//  MUtilityTests
//
//  Created by Quang Phu C. M. on 8/10/22.
//

@testable import MUtility
import Nimble
import Quick

final class JapanesePostalCodeValidatorSpec: QuickSpec {

  override func spec() {
    describe("A PostalCodeValidator") {
      context("with inputs that match the regular expression") {

        it("returns a \"valid\" result") {
          let validator = JapanesePostalCodeValidator()
          expect(validator("000-0000")).to(beTrue())
          expect(validator("0000000")).to(beTrue())
          expect(validator("123-4567")).to(beTrue())
          expect(validator("1234567")).to(beTrue())
          expect(validator("０００-００００")).to(beTrue())
          expect(validator("９９９９９９９")).to(beTrue())
          expect(validator("９0９-０00０")).to(beTrue())
          expect(validator("098⁃7654")).to(beTrue())
          expect(validator("098ー7654")).to(beTrue())
        }
      }

      context("with inputs that don't match the regular expression") {
        it("return an \"invalid\" result") {
          let validator = JapanesePostalCodeValidator()
          expect(validator("123456")).to(beFalse())   // Too short
          expect(validator("12345678")).to(beFalse()) // Too long
          expect(validator("123*4567")).to(beFalse()) // Invalid separator
          expect(validator("1234-567")).to(beFalse()) // Invalid separator placement
          expect(validator("123A-S67")).to(beFalse()) // Invalid characters
        }
      }
    }
  }
}
