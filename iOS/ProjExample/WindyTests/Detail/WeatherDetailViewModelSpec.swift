//
//  WeatherDetailViewModelSpec.swift
//  WindyTests
//
//  Created by Quang Phu C. M. on 8/9/22.
//

@testable import WindyDev
import Foundation
import Quick
import Nimble
import MService
import MTestBase
import MapKit
import MModels
import WebKit

// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length
// swiftlint:disable closure_body_length
final class WeatherDetailViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: WeatherDetailViewModel!
        var mockWeatherService: MockWeatherService!
        let place = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 123, longitude: 123)))
        var weatherDTO = WeatherDTO(ts: [], units: nil, typeSurface: [], temp: [], mclouds: [], rh: [])

        beforeEach {
            place.name = "Da Nang"
            mockWeatherService = MockWeatherService()
            viewModel = WeatherDetailViewModel(place: place, windyService: mockWeatherService)
        }

        afterEach {
            mockWeatherService = nil
            viewModel = nil
        }

        describe("A WeatherDetailViewModel") {

            // Get weather
            context("with a failure get weather response") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.getWeather { result in
                            if case let .failure(error) = result {
                                expect(error).to(equal(DummyError()))
                                expect(viewModel.isAdded).to(equal(false))
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
                    _ = weatherDTO.addLocation(place: place)
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }

                    mockWeatherService.saveToBookmarkMock = { _, completion in
                        completion?(.success(()))
                    }

                    mockWeatherService.isBookmarkedMock = { _ in
                        false
                    }
                }

                it("should emit add success") {
                    waitUntil { done in
                        viewModel.getWeather { result in
                            if case let .success(data) = result {
                                expect(data.name).to(equal(weatherDTO.locationName))
                                let isAdd = viewModel.isAdded
                                expect(isAdd).to(equal(false))
                                viewModel.addToBookmark { result in
                                    if case .success = result {
                                        expect(weatherDTO.place?.name).to(equal("Da Nang"))
                                    } else {
                                        fail("Wrong response value in the result")
                                    }
                                }
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
                    _ = weatherDTO.addLocation(place: place)
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                    mockWeatherService.saveToBookmarkMock = { _, completion in
                        completion?(.failure(DummyError()))
                    }

                    mockWeatherService.isBookmarkedMock = { _ in
                        false
                    }
                }

                it("should emit add fail") {
                    waitUntil { done in
                        viewModel.getWeather { result in
                            if case let .success(data) = result {
                                expect(data.name).to(equal(weatherDTO.locationName))
                                let isAdd = viewModel.isAdded
                                expect(isAdd).to(equal(false))
                                viewModel.addToBookmark { result in
                                    if case let .failure(error) = result {
                                        expect(error).to(equal(DummyError()))
                                    } else {
                                        fail("Wrong response value in the result")
                                    }
                                }
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
                    _ = weatherDTO.addLocation(place: place)

                    mockWeatherService.isBookmarkedMock = { _ in
                        true
                    }
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }

                    mockWeatherService.deleteBookmarkMock = { _, completion in
                        completion?(.success(()))
                    }
                }

                it("should emit delete success") {
                    waitUntil { done in
                        viewModel.getWeather { result in
                            if case let .success(data) = result {
                                expect(data.name).to(equal(weatherDTO.locationName))
                                let isAdd = viewModel.isAdded
                                expect(isAdd).to(equal(true))
                                viewModel.addToBookmark { result in
                                    if case .success = result {
                                        expect(weatherDTO.place?.name).to(equal("Da Nang"))
                                    } else {
                                        fail("Wrong response value in the result")
                                    }
                                }
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
                    _ = weatherDTO.addLocation(place: place)
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                    mockWeatherService.deleteBookmarkMock = { _, completion in
                        completion?(.failure(DummyError()))
                    }

                    mockWeatherService.isBookmarkedMock = { _ in
                        true
                    }
                }

                it("should emit add fail") {
                    waitUntil { done in
                        viewModel.getWeather { result in
                            if case let .success(data) = result {
                                expect(data.name).to(equal(weatherDTO.locationName))
                                let isAdd = viewModel.isAdded
                                expect(isAdd).to(equal(true))
                                viewModel.addToBookmark { result in
                                    if case let .failure(error) = result {
                                        expect(error).to(equal(DummyError()))
                                    } else {
                                        fail("Wrong response value in the result")
                                    }
                                }
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
