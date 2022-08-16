//
//  SearchViewModel.swift
//  Windy
//
//  Created by Rin Sang on 18/07/2022.
//

import Foundation
import MService
import MapKit
import MModels
import MUtility

protocol SearchViewModelType: ListDataSetupable {
    // Datasource
    func getHistorySearch() -> [String]
    func getMapkitItem(at indexPath: IndexPath) -> MKMapItem?

    // Events
    func saveHistorySearch(keySearch: String)
    func searchLocation(by name: String, completion: Completion<[MKMapItem]>?)
    func getWeather(place: MKMapItem, completion: (() -> Void)?)
}

final class SearchViewModel {
    private let locationService: LocationServiceType
    private let windyService: WeatherSeviceType

    // Weather location result by key search
    private var searchResult: [WeatherDTO] = []

    public init(
        locationService: LocationServiceType,
        windyService: WeatherSeviceType
    ) {
        self.locationService = locationService
        self.windyService = windyService
    }
}

extension SearchViewModel: SearchViewModelType {
    func getHistorySearch() -> [String] {
        windyService.getHistorySearch()
    }

    func getMapkitItem(at indexPath: IndexPath) -> MKMapItem? {
        searchResult[safe: indexPath.row]?.place
    }

    func saveHistorySearch(keySearch: String) {
        windyService.saveHistorySearch(keySearch: keySearch)
    }

    func numberOfItems(in section: Int) -> Int {
        searchResult.count
    }

    func cellForItem<T>(at indexPath: IndexPath, cellData: T.Type) -> T? where T: ViewData {
        guard let weatherDTO = searchResult[safe: indexPath.row] else {
            return nil
        }
        let viewdata = LocationCellViewData(weatherDTO: weatherDTO)
        return viewdata as? T
    }

    func getWeather(place: MKMapItem, completion: (() -> Void)?) {
        let params = WeatherDTO.Request(place,
                                        "gfs",
                                        ["ptype", "temp", "mclouds", "rh"],
                                        "gfEFtWI99Tk4BN7QK6EZOSPCXkvKV12w")
        windyService.getWeatherCondition(place: place, params: params) { [weak self] result in
            switch result {

            case .success(var weather):
                self?.searchResult = [weather.addLocation(place: place)]
                completion?()

            case .failure:
                completion?()
            }
        }
    }

    func searchLocation(by name: String, completion: Completion<[MKMapItem]>?) {
        locationService.searchLocation(by: name) { result in
            switch result {
            case .success(let list):
                completion?(.success(list))

            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}

struct WeatherViewData: ViewData {
    let data: WeatherDTO
}
