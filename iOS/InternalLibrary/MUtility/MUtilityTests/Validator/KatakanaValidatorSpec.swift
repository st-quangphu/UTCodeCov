//
//  KatakanaValidatorSpec.swift
//  MUtilityTests
//
//  Created by Quang Phu C. M. on 8/10/22.
//

import Foundation
@testable import MUtility
import Nimble
import Quick

final class KatakanaValidatorSpec: QuickSpec {

  override func spec() {
    describe("A KatakanaValidator") {
      let validator = KatakanaValidator()

      context("with valid input strings") {
        it("returns a \"valid\" result") {
          // Empty string
          expect(validator("")).to(beTrue())

          // Single character
          expect(validator("ン")).to(beTrue())

          // Katakana full width
          expect(validator("エフラインメジアランゲル")).to(beTrue())

          // katakana full width with middle dot
          expect(validator("ジス・イズ・アー・テスト")).to(beTrue())

          // half-width (all symbols: U+FF66 → U+FF9F)
          expect(validator("ｦｧｨｩｪｫｬｭｮｯｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ" )).to(beTrue())

          // mixed: full and half widths
          expect(validator("ジス・イズ・アー・テストｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄ")).to(beTrue())

          // dashes and spaces
          expect(validator("‑⁃–—―−ｰ﹣－- 　")).to(beTrue())
        }
      }

      context("with invalid input strings") {
        it("return an \"invalid\" result") {
          expect(validator("エフラインめじあランゲル")).to(beFalse())      // Contains hiragana 'めじあ'
          expect(validator("ジス・イズ・アー・test")).to(beFalse())       // Contains basic latin
          expect(validator("test・ジス・イズ・アー・test")).to(beFalse()) // Contains basic latin
          expect(validator("ジス・イズ・アー・テスト・123")).to(beFalse()) // Contains numeric
          expect(validator("123ジス・イズ・アー・テスト")).to(beFalse())   // Contains numeric
        }
      }
    }
  }
}
