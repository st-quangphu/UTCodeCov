//
//  URLSchemeResolverSpec.swift
//  MNetworkTests
//
//  Created by Quang Phu C. M. on 7/21/22.
//

@testable import MNetwork

import Foundation
import Quick
import Nimble
import MUtility

final class URLSchemeResolverSpec: QuickSpec {
  override func spec() {
    describe("A URLSchemeResolver") {
      context("running UI tests") {
        beforeEach {
          Macros.isRunningUITests = true
        }

        it("uses HTTP") {
          expect(URLSchemeResolver.protocol()) == "http://"
        }
      }

      context("not running UI tests") {
        beforeEach {
          Macros.isRunningUITests = false
        }

        it("uses HTTPS") {
          expect(URLSchemeResolver.protocol()) == "https://"
        }
      }
    }
  }
}
