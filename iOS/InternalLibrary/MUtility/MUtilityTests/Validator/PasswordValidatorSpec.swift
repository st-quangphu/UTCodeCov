//
//  PasswordValidatorSpec.swift
//  MUtilityTests
//
//  Created by Quang Phu C. M. on 8/10/22.
//

@testable import MUtility
import Nimble
import Quick

final class PasswordValidatorSpec: QuickSpec {
  override func spec() {
    struct PasswordExpectation: Equatable {
      let password: String
      let expectedResult: PasswordValidator.Result

      init(_ tuple: (String, PasswordValidator.Result)) {
        password = tuple.0
        expectedResult = tuple.1
      }
    }

    describe("a password validator") {
      let passwordValidator = PasswordValidator()

      context("with a list of password with expected output") {
        // cSpell: disable
        let passwordsWithExpectation = [
          ("password", .needsVariation), // needs variation
          ("p4ssword", .valid), // valid format (2 rules)
          ("p4^sw0rD", .valid), // valid format (all rules)
          ("p4sswordwith space", .invalidFormat), // valid format without the space
          ("!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~", .needsVariation), // only contains valid symbols, not enough variation
          ("n0nÉnglish", .invalidFormat), // contains non english alphabets
          ("¥password¥", .invalidFormat), // contains invalid symbol `¥`
          ("!\"#$%&'()*+,password", .valid), // contains valid symbols and chars
          ("-./:;<=>?@[\\]^_`{|}~1234", .valid), // contains valid symbols and numbers
          ("sh0rt", .invalidLength), // valid format but too short!
          ("l0ngVersionPasswordThatShouldFailValidation", .invalidLength), // valid format but too long!
          ("", .empty), // empty is not really valid
          ("1234567890abcdefghij1234567890ab", .valid), // max 32 chars boundary, valid
          ("1234567890abcdefghij1234567890abc", .invalidLength), // 33 chars, too long!
          ("1234567a", .valid), // min 8 chars boundary, valid
          ("123456a", .invalidLength) // 7 chars, too short!
        ].map(PasswordExpectation.init)
        // cSpell: enable

        it("should match the expected output") {
          let validatorResult = passwordsWithExpectation
            .map { tuple in
              PasswordExpectation((tuple.password, passwordValidator(tuple.password)))
            }
          expect(passwordsWithExpectation) == validatorResult
        }
      }
    }
  }
}

extension PasswordValidator.Result {
  var boolValue: Bool {
    self == .valid
  }
}
