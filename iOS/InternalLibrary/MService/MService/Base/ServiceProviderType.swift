//
//  ServiceProviderType.swift
//  MService
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation

public protocol ServiceProviderType {
    // Example Services
    var exampleService: ExampleServiceType { get }
    var weatherService: WeatherSeviceType { get }
    var locationService: LocationServiceType { get }
}
