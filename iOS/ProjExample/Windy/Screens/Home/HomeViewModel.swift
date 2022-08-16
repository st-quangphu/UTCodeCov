//
//  HomeViewModel.swift
//  Windy
//
//  Created by Long Vo M. on 7/25/22.
//

import Foundation
import MService
import MapKit
import MModels
import MUtility

protocol HomeViewModelType {
    // Datasource
    var locationNumber: Int { get }

    // Events
    var showActivityIndicator: ((Bool) -> Void)? { get set }

    //
    func requestLocationPermission(completion: ((CLAuthorizationStatus) -> Void)?)
    func getBookmarkedWeathers(completion: Completion<[WeatherDTO]>?)
    func getCurrentLocation(completion: Completion<MKMapItem>?)
    func getLocationWeather(index: Int, completion: Completion<WeatherDetailViewData>?)
    func viewModelForListHomeView() -> ListHomeViewModel
}

final class HomeViewModel {
    private var locationService: LocationServiceType
    private var windyService: WeatherSeviceType
    var showActivityIndicator: ((Bool) -> Void)?
    var bookmarkedWeathers = [WeatherDTO]()

    init(
        locationService: LocationServiceType,
        windyService: WeatherSeviceType
    ) {
        self.locationService = locationService
        self.windyService = windyService
    }
}

extension HomeViewModel: HomeViewModelType {

    var locationNumber: Int {
        bookmarkedWeathers.count
    }

    private func getLocation(index: Int) -> WeatherDTO? {
       bookmarkedWeathers[safe: index]
   }

    func viewModelForListHomeView() -> ListHomeViewModel {
        ListHomeViewModel(bookmarkedWeathers: bookmarkedWeathers)
    }

    private func getLocation(location: CLLocation, completion: Completion<MKMapItem>?) {
        locationService.getLocation(location: location) { result in
            DispatchQueue.main.async {
            switch result {
            case .success(let item):
                completion?(.success(item))

            case .failure(let e):
                completion?(.failure(e))
            }
            }
        }
    }

    func getBookmarkedWeathers(completion: Completion<[WeatherDTO]>?) {
        showActivityIndicator?(true)
        windyService.getBookmarks { [weak self] result in
            DispatchQueue.main.async {
                self?.showActivityIndicator?(false)
                if case .success(let item) = result {
                    self?.bookmarkedWeathers = item
                }
                completion?(result)
            }
        }
    }

    func getLocationWeather(index: Int, completion: Completion<WeatherDetailViewData>?) {
        guard let weather = getLocation(index: index) else { return }
        let location = CLLocation(
            latitude: CLLocationDegrees(weather.lat),
            longitude: CLLocationDegrees(weather.long)
        )
        getLocation(location: location) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let mapkitItem):
                this.getWeather(place: mapkitItem) { result2 in
                    DispatchQueue.main.async {
                        switch result2 {
                        case .success(let weatherDTO):
                            let viewData = WeatherDetailViewData(weatherDTO: weatherDTO)
                            completion?(.success(viewData))

                        case .failure(let e):
                            completion?(.failure(e))
                        }
                    }
                }

            case .failure(let e):
                DispatchQueue.main.async {
                    completion?(.failure(e))
                }
            }
        }
    }

    func requestLocationPermission(completion: ((CLAuthorizationStatus) -> Void)?) {
        locationService.requestPermission { status in
            DispatchQueue.main.async {
            completion?(status)
            }
        }
    }

    func getWeather(place: MKMapItem, completion: Completion<WeatherDTO>?) {
        let params = WeatherDTO.Request(place,
                                        "gfs",
                                        ["ptype", "temp", "mclouds", "rh"],
                                        "gfEFtWI99Tk4BN7QK6EZOSPCXkvKV12w")
        showActivityIndicator?(true)
        windyService.getWeatherCondition(place: place, params: params) { [weak self] result in
            DispatchQueue.main.async {
            self?.showActivityIndicator?(false)
            switch result {
            case .success(let weather):
                completion?(.success(weather))

            case .failure(let e):
                completion?(.failure(e))
            }
            }
        }
    }

    func getCurrentLocation(completion: Completion<MKMapItem>?) {
        locationService.getCurrentLcation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let place):
                    var weather = WeatherDTO()
                    _ = weather.addLocation(place: place)
                    self?.bookmarkedWeathers.append(weather)
                    completion?(.success(place))

                case .failure(let e):
                    completion?(.failure(e))
                }
            }
        }
    }
}
