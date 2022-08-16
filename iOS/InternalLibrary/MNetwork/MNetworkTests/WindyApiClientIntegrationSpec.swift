//
//  WindyApiClientIntegrationSpec.swift
//  MNetworkTests
//
//  Created by Quang Phu C. M. on 7/21/22.
//

@testable import MNetwork

import Foundation
import Quick
import Nimble
import MModels
import MapKit

// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length
final class WindyApiClientIntegrationSpec: QuickSpec {

    override func spec() {

        var baseApiClient: ApiClient!
        var windyApiClient: WindyApiClient!

        beforeEach {
            baseApiClient = ApiClient()
            windyApiClient = WindyApiClient(apiClient: baseApiClient)
        }

        afterEach {
            baseApiClient = nil
            windyApiClient = nil
        }
        let place = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 16.043_855,
                    longitude: 108.215_943
                )
            )
        )
        let invalidPlace = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                )
            )
        )
        let validRequest = WeatherDTO.Request(
            place,
            "gfs",
            ["ptype", "temp", "mclouds"],
            "gfEFtWI99Tk4BN7QK6EZOSPCXkvKV12w"
        )
        let invalidRequest = WeatherDTO.Request(
            invalidPlace,
            "",
            [],
            ""
        )

        describe("A WindyApiClient") {
            context("with a valid access token") {
                it("can successfully get windy response") {
                    waitUntil(timeout: .integrationTestTimeout) { done in
                        windyApiClient.getWeatherCondition(params: validRequest) { result in
                            guard case .success = result else {
                              fail()
                              return
                            }
                            done()
                        }
                    }
                }
            }

            context("with an invalid access token") {
                it("should fail getting windy response") {
                    waitUntil(timeout: .integrationTestTimeout) { done in
                        windyApiClient.getWeatherCondition(params: invalidRequest) { result in
                            guard case .failure = result else {
                              fail()
                              return
                            }
                            done()
                        }
                    }
                }
            }
        }
    }
}
