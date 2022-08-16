//
//  MockWindyApiClient.swift
//  MTestBase
//
//  Created by Quang Phu C. M. on 7/21/22.
//

import Foundation
import MNetwork
import MModels

public final class MockWindyApiClient: WindyApiClientType {

    public init() {}

    // MARK: - Mock properties
    public var getWeatherConditionMock: ((WeatherDTO.Request, DecodableCompletion<WeatherDTO>?) -> Void)?

    // MARK: - Protocol Implement
    public func getWeatherCondition(
        params: WeatherDTO.Request,
        _ completion: DecodableCompletion<WeatherDTO>?
    ) {
        getWeatherConditionMock?(params, completion)
    }
}
