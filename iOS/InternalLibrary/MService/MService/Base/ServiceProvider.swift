//
//  ServiceProvider.swift
//  MService
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation
import MNetwork
import MUtility
import MDataStore

// MARK: - Constuctor

public struct ServiceProvider: ServiceProviderType {
    private let apiClient: ApiClientType

    // Contains all of services in project
    public let exampleService: ExampleServiceType
    public let weatherService: WeatherSeviceType
    public let locationService: LocationServiceType
    // Database Accessors
    private let database: DatabaseWriter

    public init(
        environment: NetworkEnvironment,
        sessionManager: SessionManageable,
        notificationCenter: NotificationCenter = .default,
        database: DatabaseWriter
    ) {
        apiClient = ApiClient(
            environment: environment,
            apiKey: "",
            sessionManager: sessionManager,
            notificationCenter: notificationCenter
        )
        self.database = database

        // Example Services
        let exampleApiClient = ExampleApiClient(apiClient: apiClient, environment: environment)
        exampleService = ExampleService(apiClient: exampleApiClient)

        let coredataAccessor = CoreDataAccessor(databaseWriter: database)
        let weatherDataStore = WeatherDataStoreAccessor(dbAccesor: coredataAccessor)
        let weatherApiClient = WindyApiClient(apiClient: apiClient)
        weatherService = WeatherSevice(
            apiClient: weatherApiClient,
            datastore: weatherDataStore
        )

        locationService = LocationService()
    }
}
