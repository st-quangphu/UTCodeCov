//
//  MockServiceProvider.swift
//  MTestBase
//
//  Created by Quang Phu C. M. on 7/21/22.
//

import Foundation
import MService

public final class MockServiceProvider: ServiceProviderType {

    // Mock Objects
    public var exampleServiceMock: ExampleServiceType?

    public var weatherServiceMock: WeatherSeviceType?

    public var locationServiceMock: LocationServiceType?

    //
    public var exampleService: ExampleServiceType {
        exampleServiceMock!
    }

    public var weatherService: WeatherSeviceType {
        weatherServiceMock!
    }

    public var locationService: LocationServiceType {
        locationServiceMock!
    }
}
