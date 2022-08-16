//
//  ExampleEndpoint.swift
//  MNetwork
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation
import MUtility

public enum ExampleEndpoint {
    case find(key: String)
}

extension ExampleEndpoint: Endpoint {
    public var server: APIServer {
        .none
    }

    public var path: String {
        "api_path"
    }

    public var responseDecoder: AnyDecoder {
        JSONDecoder.decoder(keyDecodingStrategy: .useDefaultKeys)
    }

    public var requestType: RequestType {
        switch self {
        case .find(let key):
            return .requestUrlParameters(parameters: ["key": key])
        }
    }
}
