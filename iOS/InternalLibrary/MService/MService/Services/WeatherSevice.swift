//
//  WeatherSevice.swift
//  MService
//
//  Created by Long Vo M. on 7/13/22.
//
import Foundation
import MModels
import MNetwork
import MapKit
import MError
import MDataStore

public protocol WeatherSeviceType {

    func getBookmarks(completion: Completion<[WeatherDTO]>?)
    func saveToBookmark(weather: WeatherDTO, completion: Completion<Void>?)
    func deleteBookmark(weather: WeatherDTO, completion: Completion<Void>?)
    func isBookmarked(weather: WeatherDTO) -> Bool
    func getWeatherCondition(place: MKMapItem, params: WeatherDTO.Request, completion: Completion<WeatherDTO>?)
    func saveHistorySearch(keySearch: String)
    func getHistorySearch() -> [String]
}

public class WeatherSevice {
    private let apiClient: WindyApiClientType
    private let datastore: WeatherDataStoreAccessorType

    public init(
        apiClient: WindyApiClientType,
        datastore: WeatherDataStoreAccessorType
    ) {
        self.apiClient = apiClient
        self.datastore = datastore
    }
}

extension WeatherSevice: WeatherSeviceType {
    public func getWeatherCondition(place: MKMapItem, params: WeatherDTO.Request, completion: Completion<WeatherDTO>?) {
        apiClient.getWeatherCondition(params: params) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    var weather = data
                    weather = weather.addLocation(place: place)
                    completion?(.success(weather))
                case .failure(let e): completion?(.failure(e))
                }
            }
        }
    }

    public func getBookmarks(completion: Completion<[WeatherDTO]>?) {
        let result = datastore.getBookmarks()
        DispatchQueue.main.async {
            switch result {
            case .success(let items):
                completion?(.success(items))

            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }

    public func saveToBookmark(weather: WeatherDTO, completion: Completion<Void>?) {
        let result = datastore.saveToBookmark(weather: weather)
        DispatchQueue.main.async {
            switch result {
            case .success:
                completion?(.success(()))

            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }

    public func deleteBookmark(weather: WeatherDTO, completion: Completion<Void>?) {
        let result = datastore.deteleBookmark(weather: weather)
        DispatchQueue.main.async {
            switch result {
            case .success:
                completion?(.success(()))

            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }

    public func isBookmarked(weather: WeatherDTO) -> Bool {
        datastore.isBookmarked(weather: weather)
    }

    public func saveHistorySearch(keySearch: String) {
        datastore.saveHistorySearch(keySearch: keySearch)
    }

    public func getHistorySearch() -> [String] {
        datastore.getHistorySearch()
    }
}
