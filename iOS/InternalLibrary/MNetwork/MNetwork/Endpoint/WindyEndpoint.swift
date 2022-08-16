//
//  WindyEndpoint.swift
//  MNetwork
//
//  Created by Long Vo M. on 7/13/22.
//

import Foundation
import MUtility
import MModels

public enum WindyEndpoint {
    case getWeatherCondition(params: WeatherDTO.Request)
}

extension WindyEndpoint: Endpoint {
    public var server: APIServer {
        .none
    }

    public var path: String {
        "/api/point-forecast/v2"
    }

    public var method: HttpMethod {
        .post
    }

    public var responseDecoder: AnyDecoder {
        JSONDecoder.decoder(keyDecodingStrategy: .useDefaultKeys)
    }

    public var requestType: RequestType {
        switch self {
        case .getWeatherCondition(let params):
            return .requestRawParameters(parameters: params.params)
        }
    }
}
