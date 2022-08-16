//
//  WeatherServiceSpec.swift
//  MServiceTests
//
//  Created by Duong Nguyen T. on 8/8/22.
//

@testable import MService

import Foundation
import MTestBase
import Quick
import Nimble
import MModels
import MError
import MapKit
import MDataStore

// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length
// swiftlint:disable closure_body_length
final class WeatherServiceSpec: QuickSpec {

    override func spec() {

        var targetService: WeatherSevice!
        var mockApiClient: MockWindyApiClient!

        beforeEach {
            mockApiClient = MockWindyApiClient()
            let database = AppDatabase().persistentContainer.viewContext
            let coredataAccessor = CoreDataAccessor(databaseWriter: database)
            let weatherDataStore = WeatherDataStoreAccessor(dbAccesor: coredataAccessor)

            targetService = WeatherSevice(apiClient: mockApiClient, datastore: weatherDataStore)
        }

        afterEach {
            targetService = nil
            mockApiClient = nil
        }

        describe("A WindyApiClient") {
            context("with a valid request") {
                let weatherResponse = WeatherDTO.getFixtureObject
                let place = MKMapItem(
                    placemark: MKPlacemark(
                        coordinate: CLLocationCoordinate2D(
                            latitude: 16.043_855,
                            longitude: 108.215_943
                        )
                    )
                )
                let validRequest = WeatherDTO.Request(
                    place,
                    "gfs",
                    ["ptype", "temp", "mclouds"],
                    "gfEFtWI99Tk4BN7QK6EZOSPCXkvKV12w"
                )
                it("should return success response") {
                    targetService.getWeatherCondition(
                        place: place,
                        params: validRequest,
                        completion: { result in
                            if case let .success(response) = result {
                                expect(response.locationName).to(equal(weatherResponse.locationName))
                            } else {
                                fail("Wrong response value in the result")
                            }
                        }
                    )
                }
            }
            context("with a invalid request") {
                let weatherResponse = WeatherDTO.getFixtureObject
                let invalidPlace = MKMapItem(
                    placemark: MKPlacemark(
                        coordinate: CLLocationCoordinate2D(
                            latitude: 0,
                            longitude: 0
                        )
                    )
                )
                let invalidRequest = WeatherDTO.Request(
                    invalidPlace,
                    "",
                    [],
                    ""
                )
                it("should return fail response") {
                    targetService.getWeatherCondition(
                        place: invalidPlace,
                        params: invalidRequest,
                        completion: { result in
                            if case let .success(response) = result {
                                expect(response.locationName).to(equal(weatherResponse.locationName))
                            } else {
                                fail("Wrong response value in the result")
                            }
                        }
                    )
                }
            }
        }
    }
}
