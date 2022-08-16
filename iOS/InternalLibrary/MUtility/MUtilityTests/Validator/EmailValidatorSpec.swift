//
//  EmailValidatorSpec.swift
//  MUtilityTests
//
//  Created by Quang Phu C. M. on 8/10/22.
//

@testable import MUtility
import Nimble
import Quick

// swiftlint:disable function_body_length closure_body_length
final class EmailValidatorSpec: QuickSpec {
  struct EmailExpectation: Equatable {
    let email: String
    let isValid: Bool

    init(_ tuple: (String, Bool)) {
      email = tuple.0
      isValid = tuple.1
    }
  }

  override func spec() {
    describe("an email validator") {
      let emailValidator = EmailValidator()

      context("with a list of email and expected output from a source") {

        // cSpell: disable
        let emailsWithExpectation = [
          // Email cases taken from: https://blogs.msdn.microsoft.com/testing123/2009/02/06/email-address-test-cases/
          (#"email@domain.com"#, true), // Valid email
          (#"firstname.lastname@domain.com"#, true), // Email contains dot in the address field
          (#"email@subdomain.domain.com"#, true), // Email contains dot with subdomain
          (#"firstname+lastname@domain.com"#, true), // Plus sign is considered valid character
          (#""email"@domain.com"#, false), // Quotes are not an accepted character
          (#"1234567890@domain.com"#, true), // Digits in address are valid
          (#"email@domain-one.com"#, true), // Dash in domain name is valid
          (#"_______@domain.com"#, true), // Underscore in the address field is valid
          (#"email@domain.name"#, true), // .name is valid Top Level Domain name
          (#"email@domain.co.jp"#, true), // Dot in Top Level Domain name also considered valid
//        (use co.jp as example here)
          (#"firstname-lastname@domain.com"#, true), // Dash in address field is valid
          (#"plainaddress"#, false), // Missing @ sign and domain
          (#"#@%^%#$@#$@#.com"#, false), // Garbage
          (#"@domain.com"#, false), // Missing username
          (#"Joe Smith <email@domain.com>"#, false), // Encoded html within email is invalid
          (#"email.domain.com"#, false), // Missing @
          (#"email@domain@domain.com"#, false), // Two @ sign
          (#"あいうえお@domain.com"#, false), // Unicode char as address
          (#"email@domain.com (Joe Smith)"#, false), // Text followed email is not allowed
          (#"email@domain"#, false), // Missing top level domain (.com/.net/.org/etc)
          (#"email@111.222.333.44444"#, false) // Invalid IP format
        ].map(EmailExpectation.init)
        // cSpell: enable

        it("should match the expected output") {
          let validatorResult = emailsWithExpectation
            .map { tuple in EmailExpectation((tuple.email, emailValidator(tuple.email).boolValue)) }
          expect(emailsWithExpectation) == validatorResult
        }
      }

      context("with a list of expected emails based on requirements") {
        // cSpell: disable
        let emailsWithExpectation = [
          ("address@domain.com", true), // perfectly fine email
          ("addréss@domain.com", false), // non engilsh character is invalid.
          ("address@my@domain.com", false), // 2 `@` is invalid.
          ("address@domain.co.id", true), // 2 `.` after `@` is fine.
          ("address @domain.co.id", false), // spaces are not welcome.
          ("address@ domain.co.id", false), // spaces are not welcome.
          ((0 ... 99).reduce(into: "") { r, _ in r.append("1") } + "@domain.com", false) // more than 100 chars
        ].map(EmailExpectation.init)
        // cSpell: enable

        it("should match the expected output") {
          let validatorResult = emailsWithExpectation
            .map { tuple in EmailExpectation((tuple.email, emailValidator(tuple.email).boolValue)) }
          expect(emailsWithExpectation) == validatorResult
        }
      }
    }
  }
}

// swiftlint:enable function_body_length closure_body_length

extension EmailValidator.Result {
  var boolValue: Bool {
    self == .valid
  }
}
