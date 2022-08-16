//
//  ApiClient+Test.swift
//  MNetworkTests
//
//  Created by Quang Phu C. M. on 7/21/22.
//

@testable import MNetwork
import Foundation

extension ApiClient {

  convenience init() {
    self.init(
      environment: .dev,
      apiKey: "",
      sessionManager: SessionManager.default
    )
  }
}
