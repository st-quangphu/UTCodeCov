//
//  SearchViewModelSpec.swift
//  WindyTests
//
//  Created by Tri Nguyen T. [2] on 10/08/2022.
//

@testable import WindyDev
import Quick
import Nimble
import MTestBase
import MModels
import MService
import MapKit

// swiftlint:disable implicitly_unwrapped_optional
final class SearchViewModelSpec: QuickSpec {
    // swiftlint:disable function_body_length
    override func spec() {
        var viewModel: SearchViewModel!
        var mockWeatherService: MockWeatherService!
        var mockLocationService: MockLocationService!
        let place = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 123, longitude: 123)))
        var weatherDTO = WeatherDTO(ts: [], units: nil, typeSurface: [], temp: [], mclouds: [], rh: [])
        var searchResult: [WeatherDTO] = []
        var historySearch: [String] = []

        beforeEach {
            place.name = "Da Nang"
            mockWeatherService = MockWeatherService()
            mockLocationService = MockLocationService()
            viewModel = SearchViewModel(
                locationService: mockLocationService,
                windyService: mockWeatherService
            )
            searchResult = []
            historySearch = []
        }

        afterEach {
            mockWeatherService = nil
            mockLocationService = nil
            viewModel = nil
            searchResult = []
            historySearch = []
        }

        // swiftlint:disable closure_body_length
        describe("A SearchViewModel") {
            // Search Location
            context("with a failure seach location response") {
                beforeEach {
                    mockLocationService.searchLocationMock = { completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.searchLocation(by: "Da Nang") { result in
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

            context("with a success search location response") {
                beforeEach {
                    mockLocationService.searchLocationMock = { completion in
                        completion?(.success([place]))
                    }
                }

                it("should emit an success") {
                    waitUntil { done in
                        viewModel.searchLocation(by: place.name ?? "Da Nang") { result in
                            if case let .success(data) = result {
                                expect(data.first?.name).to(equal(place.name))
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
                }

                it("should emit an error") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            expect(searchResult.count).to(equal(0))
                            done()
                        }
                    }
                }
            }

            context("with a success get weather response") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        searchResult.append(weatherDTO)
                        completion?(.success(weatherDTO))
                    }
                }

                it("should emit an success") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            expect(searchResult.count).to(beGreaterThan(0))
                            done()
                        }
                    }
                }
            }

            // saveHistorySearch
            context("with a success save history search") {
                beforeEach {
                    mockWeatherService.saveHistorySearchMock = { keyword in
                        historySearch.append(keyword)
                    }
                }

                it("should emit an success") {
                    waitUntil { done in
                        let keySearch = "Ha Noi"
                        viewModel.saveHistorySearch(keySearch: keySearch)
                        expect(historySearch).to(contain(keySearch))
                        done()
                    }
                }
            }

            // getHistorySearch
            context("with a success get history search") {
                beforeEach {
                    mockWeatherService.getHistorySearchMock = {
                        historySearch = ["Hue", "Da Nang", "Quang Nam"]
                        return historySearch
                    }
                }

                it("should emit an success") {
                    waitUntil { done in
                        let search = viewModel.getHistorySearch()
                        expect(search).to(equal(historySearch))
                        done()
                    }
                }
            }

            // getMapkitItem
            context("with a nil value get mapkit") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an empty value") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            let mapkit = viewModel.getMapkitItem(at: IndexPath(row: 0, section: 0))
                            expect(mapkit).to(beNil())
                            done()
                        }
                    }
                }
            }

            context("with a success get mapkit") {
                beforeEach {
                    _ = weatherDTO.addLocation(place: place)
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                }

                it("should emit a value") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            let mapkit = viewModel.getMapkitItem(at: IndexPath(row: 0, section: 0))
                            expect(mapkit).notTo(beNil())
                            done()
                        }
                    }
                }
            }

            // numberOfItems
            context("with a empty value number of items") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an empty value") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            let numberOfItems = viewModel.numberOfItems(in: 0)
                            expect(numberOfItems).to(equal(0))
                        }
                        done()
                    }
                }
            }

            context("with a value number of items") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                }

                it("should emit a value") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            let numberOfItems = viewModel.numberOfItems(in: 0)
                            expect(numberOfItems).to(beGreaterThan(0))
                            done()
                        }
                    }
                }
            }


            // cellForItem
            context("with a empty value cellForItem") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.failure(DummyError()))
                    }
                }

                it("should emit an empty value") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            let cellForItem = viewModel.cellForItem(
                                at: IndexPath(row: 0, section: 0),
                                cellData: LocationCellViewData.self
                            )
                            expect(cellForItem).to(beNil())
                        }
                        done()
                    }
                }
            }

            context("with a value cellForItem") {
                beforeEach {
                    mockWeatherService.getWeatherConditionMock = { _, _, completion in
                        completion?(.success(weatherDTO))
                    }
                }

                it("should emit a value") {
                    waitUntil { done in
                        viewModel.getWeather(place: place) {
                            let cellForItem = viewModel.cellForItem(
                                at: IndexPath(row: 0, section: 0),
                                cellData: LocationCellViewData.self
                            )
                            expect(cellForItem).notTo(beNil())
                        }
                        done()
                    }
                }
            }
        }
    }
}
