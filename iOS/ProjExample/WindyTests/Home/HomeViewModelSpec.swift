//
//  HomeViewModelSpec.swift
//  WindyTests
//
//  Created by Duong Nguyen T. on 8/15/22.
//


@testable import WindyDev
import Quick
import Nimble
import MTestBase
import MModels
import MService
import MapKit

// swiftlint:disable implicitly_unwrapped_optional
final class HomeViewModelSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        var viewModel: HomeViewModel!
        var mockWeatherService: MockWeatherService!
        var mockLocationService: MockLocationService!
        var bookmarkedWeathers = [WeatherDTO]()
        let place = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 123, longitude: 123)))
        var weatherDTO = WeatherDTO(ts: [], units: nil, typeSurface: [], temp: [], mclouds: [], rh: [])
        let location = CLLocation(
            latitude: CLLocationDegrees(123),
            longitude: CLLocationDegrees(123)
        )

        beforeEach {
            place.name = "Da Nang"
            mockWeatherService = MockWeatherService()
            mockLocationService = MockLocationService()
            viewModel = HomeViewModel(
                locationService: mockLocationService,
                windyService: mockWeatherService
            )
            bookmarkedWeathers = []
            viewModel.bookmarkedWeathers = bookmarkedWeathers
        }

        afterEach {
            mockWeatherService = nil
            mockLocationService = nil
            viewModel = nil
            bookmarkedWeathers = []
        }

        // swiftlint:disable closure_body_length
        describe("A HomeViewModel") {

            // Get Current Location
            context("with a failure get current location") {
                beforeEach {
                    mockLocationService.getCurrentLocationMock = { completion in
                        completion?(.failure(DummyError()))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.getCurrentLocation { result in
                            if case let .failure(error) = result {
                                expect(error).to(equal(DummyError()))
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }

            context("with a success get current location") {
                beforeEach {
                    mockLocationService.getCurrentLocationMock = { completion in
                        completion?(.success(place))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                }

                it("should emit an success") {
                    waitUntil { done in
                        viewModel.getCurrentLocation { result in
                            if case let .success(data) = result {
                                expect(data.name).to(equal(place.name))
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }


            // Get Weather
            context("with a failure getWeather response") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.failure(DummyError()))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) { result in
                            if case let .failure(error) = result {
                                expect(error).to(equal(DummyError()))
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }

            context("with a success get weather response") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                }

                it("should emit an success") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) { result in
                            if case let .success(data) = result {
                                expect(data.locationName).notTo(beNil())
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }

            // Get Location Weather
            context("with a failure get Weather response") {
                beforeEach {
                    mockLocationService.getLocationMock = { completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an error") {
                    waitUntil { done in
                        expect(bookmarkedWeathers.count).to(equal(0))
                        done()
                    }
                }
            }

            context("with a failure get Weather response") {
                beforeEach {
                    mockLocationService.getCurrentLocationMock = { completion in
                        completion?(.success(place))
                    }
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                    mockLocationService.getLocationMock = { completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.getLocationWeather(index: 0) { result in
                            if case let .failure(error) = result {
                                expect(error).to(equal(DummyError()))
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }

            context("with a failure get Weather response") {
                beforeEach {
                    mockLocationService.getCurrentLocationMock = { completion in
                        completion?(.success(place))
                    }
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.failure(DummyError()))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                    mockLocationService.getLocationMock = { completion in
                        completion?(.success(place))
                    }
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.getLocationWeather(index: 0) { result in
                            if case let .failure(error) = result {
                                expect(error).to(equal(DummyError()))
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }

            context("with a success get Weather response") {
                beforeEach {
                    mockLocationService.getCurrentLocationMock = { completion in
                        completion?(.success(place))
                    }
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                    _ = weatherDTO.addLocation(place: place)
                    viewModel.bookmarkedWeathers.append(weatherDTO)
                    mockLocationService.getLocationMock = { completion in
                        completion?(.success(place))
                    }
                }

                it("should emit an success") {
                    waitUntil { done in
                        viewModel.getLocationWeather(index: 0) { result in
                            if case let .success(data) = result {
                                expect(data.name).notTo(beNil())
                            } else {
                                fail("Wrong response value in the result")
                            }
                            done()
                        }
                    }
                }
            }
        }
    }
}
