//
//  WeatherDetailViewModel.swift
//  Windy
//
//  Created by Duong Nguyen T. on 7/25/22.
//

import Foundation
import MService
import MapKit
import MModels
import MUtility

protocol WeatherDetailViewModelType {
    // Datasource
    var isAdded: Bool { get }

    //
    var showActivityIndicator: ((Bool) -> Void)? { get set }

    //
    func getWeather(completion: Completion<WeatherDetailViewData>?)
    func addToBookmark(completion: Completion<Void>?)
}

final class WeatherDetailViewModel: WeatherDetailViewModelType {
    private let windyService: WeatherSeviceType
    private var place: MKMapItem
    private var currentWeather: WeatherDTO?

    var showActivityIndicator: ((Bool) -> Void)?

    var isAdded: Bool {
        if let item = currentWeather {
            return checkSavedWeather(weather: item)
        }
        return false
    }

    init(
        place: MKMapItem,
        windyService: WeatherSeviceType
    ) {
        self.place = place
        self.windyService = windyService
    }

//    var placeName: String {
//        let placemark = place.placemark
//        let city = placemark.locality ?? ""
//        let country = placemark.country ?? ""
//        return city.isEmpty ? country : city
//    }

    func getWeather(completion: Completion<WeatherDetailViewData>?) {
        let params = WeatherDTO.Request(place,
                                        "gfs",
                                        ["ptype", "temp", "mclouds", "rh"],
                                        "gfEFtWI99Tk4BN7QK6EZOSPCXkvKV12w")
        showActivityIndicator?(true)
        windyService.getWeatherCondition(place: place, params: params) { [weak self] result in
            guard let this = self else { return }
            this.showActivityIndicator?(false)
            switch result {
            case .success(let weather):
                let viewData = WeatherDetailViewData(weatherDTO: weather)
                this.currentWeather = weather
                completion?(.success(viewData))

            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }

    func addToBookmark(completion: Completion<Void>?) {
        guard let currentWeather = currentWeather else { return }
        let isSavedBookmark = checkSavedWeather(weather: currentWeather)
        if isSavedBookmark {
            deteleWeather(weather: currentWeather) { resutl in
                completion?(resutl)
            }
        } else {
            addWeather(weather: currentWeather) { resutl in
                completion?(resutl)
            }
        }
    }
}

// MARK: - Helper
extension WeatherDetailViewModel {
    private func checkSavedWeather(weather: WeatherDTO) -> Bool {
        windyService.isBookmarked(weather: weather)
    }

    private func deteleWeather(weather: WeatherDTO, completion: Completion<Void>?) {
        windyService.deleteBookmark(weather: weather) { result in
            switch result {
            case .success:
                completion?(.success(()))

            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }

    private func addWeather(weather: WeatherDTO, completion: Completion<Void>?) {
        windyService.saveToBookmark(weather: weather) { result in
            switch result {
            case .success:
                completion?(.success(()))

            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }
}
