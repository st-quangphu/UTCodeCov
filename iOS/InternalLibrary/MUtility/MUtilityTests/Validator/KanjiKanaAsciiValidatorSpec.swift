//
//  KanjiKanaAsciiValidatorSpec.swift
//  MUtilityTests
//
//  Created by Quang Phu C. M. on 8/10/22.
//

// swiftlint:disable closure_body_length

@testable import MUtility
import Foundation
import Nimble
import Quick

final class KanjiKanaAsciiValidatorSpec: QuickSpec {

  override func spec() {
    describe("The KanjiKanaAsciiValidator") {
      let validator = KanjiKanaAsciiValidator()

      context("with valid input strings") {
        it("returns true") {
          // cSpell: disable
          expect(validator("")).to(beTrue())

          // Katakana
          expect(validator("゠  ァ  ア  ィ  イ  ゥ  ウ  ェ  エ  ォ  オ  カ  ガ  キ  ギ  ク")).to(beTrue())
          expect(validator("グ  ケ  ゲ  コ  ゴ  サ  ザ  シ  ジ  ス  ズ  セ  ゼ  ソ  ゾ  タ")).to(beTrue())
          expect(validator("ダ  チ  ヂ  ッ  ツ  ヅ  テ  デ  ト  ド  ナ  ニ  ヌ  ネ  ノ  ハ")).to(beTrue())
          expect(validator("バ  パ  ヒ  ビ  ピ  フ  ブ  プ  ヘ  ベ  ペ  ホ  ボ  ポ  マ  ミ")).to(beTrue())
          expect(validator("ム  メ  モ  ャ  ヤ  ュ  ユ  ョ  ヨ  ラ  リ  ル  レ  ロ  ヮ  ワ")).to(beTrue())
          expect(validator("ヰ  ヱ  ヲ  ン  ヴ  ヵ  ヶ  ヷ  ヸ  ヹ  ヺ  ・  ー  ヽ  ヾ  ヿ")).to(beTrue())

          expect(validator("ｦ  ｧ  ｨ  ｩ  ｪ  ｫ  ｬ  ｭ  ｮ  ｯ")).to(beTrue())
          expect(validator("ｰ  ｱ  ｲ  ｳ  ｴ  ｵ  ｶ  ｷ  ｸ  ｹ  ｺ  ｻ  ｼ  ｽ  ｾ  ｿ")).to(beTrue())
          expect(validator("ﾀ  ﾁ  ﾂ  ﾃ  ﾄ  ﾅ  ﾆ  ﾇ  ﾈ  ﾉ  ﾊ  ﾋ  ﾌ  ﾍ  ﾎ  ﾏ")).to(beTrue())
          expect(validator("ﾐ  ﾑ  ﾒ  ﾓ  ﾔ  ﾕ  ﾖ  ﾗ  ﾘ  ﾙ  ﾚ  ﾛ  ﾜ  ﾝ  ﾞ  ﾟ")).to(beTrue())

          // Hiragana
          expect(validator("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそ")).to(beTrue())
          expect(validator("ぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺ")).to(beTrue())
          expect(validator("ほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔゕゖ")).to(beTrue())
          expect(validator("゙ ゚ ゛゜ゝ ゞ ゟ")).to(beTrue())

          // Kanji
          expect(validator("只諏 夷簾 餌威")).to(beTrue())
          expect(validator("丯丰亍仡份仿伃伋你佈佉佖佟佪佬佾侊侔侗")).to(beTrue())

          // Ascii
          expect(validator("01234567890")).to(beTrue())  // Digits
          expect(validator("ABCDEFGHIJKLMNOPQRSTUVWXYZ")).to(beTrue()) // Capital latin
          expect(validator("abcdefghijklmnopqrstuvwxyz")).to(beTrue()) // Lower case latin
          expect(validator("!\"#$%&'()*+,-.:;<=>?@[\\]^_`{|}~")).to(beTrue()) // Punctuation and symbols

          // Test cases extracted from the backend
          // (full_half_width_validator_spec.rb @ bcn-digital-service git repository)
          expect(validator("漢字ひらがなカタカナａｂｃ１２３")).to(beTrue())
          expect(validator("ABCｴｲﾋｼ123-()*&,./")).to(beTrue())
          // cSpell: enable
        }
      }

      context("with invalid input strings") {
        it("returns false") {
          expect(validator(nil)).to(beFalse())
          expect(validator("😀️")).to(beFalse())
          expect(validator("£")).to(beFalse())
          expect(validator("→")).to(beFalse())

          // Test cases extracted from the backend
          expect(validator("①")).to(beFalse())
          expect(validator("㬢")).to(beFalse())

          expect(validator("￡")).to(beFalse())
          expect(validator("㐈")).to(beFalse())
          expect(validator("㙐")).to(beFalse())
        }
      }
    }
  }
}
