//
//  WeatherApiClients.swift
//  MNetwork
//
//  Created by Long Vo M. on 7/13/22.
//

import Foundation
import MModels

public protocol WindyApiClientType {

    func getWeatherCondition(
        params: WeatherDTO.Request,
        _ completion: DecodableCompletion<WeatherDTO>?
    )
}

public class WindyApiClient {
    private let apiClient: ApiClientType

    public init(apiClient: ApiClientType) {
        self.apiClient = apiClient
    }
}

extension WindyApiClient: WindyApiClientType {
    public func getWeatherCondition(params: WeatherDTO.Request, _ completion: DecodableCompletion<WeatherDTO>?) {
        apiClient.request(
            WindyEndpoint.getWeatherCondition(params: params),
            decodableResponseType: .body,
            completion: completion
        )
    }
}
