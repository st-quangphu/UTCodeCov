//
//  MockWeatherService.swift
//  MTestBase
//
//  Created by Quang Phu C. M. on 7/21/22.
//

import Foundation
import MService
import MModels
import MapKit

public final class MockWeatherService: WeatherSeviceType {
    // MARK: - Mocks
    public var getBookmarksMock: ((Completion<[WeatherDTO]>?) -> Void)?
    public var saveToBookmarkMock: ((WeatherDTO, Completion<Void>?) -> Void)?
    public var deleteBookmarkMock: ((WeatherDTO, Completion<Void>?) -> Void)?
    public var isBookmarkedMock: ((WeatherDTO) -> Bool)?
    public var getWeatherConditionMock: ((MKMapItem, WeatherDTO.Request, Completion<WeatherDTO>?) -> Void)?
    public var saveHistorySearchMock: ((String) -> Void)?
    public var getHistorySearchMock: (() -> [String])?

    public init() {}

    // MARK: - Protocol implements
    public func getWeatherCondition(place: MKMapItem, params: WeatherDTO.Request, completion: Completion<WeatherDTO>?) {
        getWeatherConditionMock?(place, params, completion)
    }

    public func getBookmarks(completion: Completion<[WeatherDTO]>?) {
        getBookmarksMock?(completion)
    }

    public func saveToBookmark(weather: WeatherDTO, completion: Completion<Void>?) {
        saveToBookmarkMock?(weather, completion)
    }

    public func deleteBookmark(weather: WeatherDTO, completion: Completion<Void>?) {
        deleteBookmarkMock?(weather, completion)
    }

    public func isBookmarked(weather: WeatherDTO) -> Bool {
        isBookmarkedMock?(weather) ?? false
    }

    public func saveHistorySearch(keySearch: String) {
        saveHistorySearchMock?(keySearch)
    }

    public func getHistorySearch() -> [String] {
        getHistorySearchMock?() ?? []
    }
}
