//
//  WeatherDetailView.swift
//  Windy
//
//  Created by Long Vo M. on 7/25/22.
//

import UIKit
import MUtility
import MapKit
import MUIComponents
import MModels

class WeatherDetailView: ParentView {

    @IBOutlet private weak var rainForecastView: RainForecastView!
    @IBOutlet private weak var weatherInformationView: WeatherInfoView!
    @IBOutlet private weak var overallWeatherView: OverallWeatherView!

    func loadData(data: WeatherDetailViewData) {
        DispatchQueue.main.async {
            self.rainForecastView.isHidden = !data.isRain
            if data.isRain {
                self.rainForecastView.setData(data: data.rainForecastViewData)
            }
            self.overallWeatherView.loadData(data: data.overallWeather)
            self.weatherInformationView.loadData(data: data.weatherInformation)
        }
    }
}

struct WeatherDetailViewData: ViewData {
    let name: String
    let isRain: Bool
    let overallWeather: OverallWeatherViewData
    let weatherInformation: WeatherInfoViewData
    let rainForecastViewData: RainForecastViewData

    init(weatherDTO: WeatherDTO) {
        overallWeather = OverallWeatherViewData(weatherDTO: weatherDTO)
        weatherInformation = WeatherInfoViewData(weatherDTO: weatherDTO)
        rainForecastViewData = RainForecastViewData(weatherDTO: weatherDTO)
        isRain = (weatherDTO.currentWeather?.weatherType == .rainy)
        name = weatherDTO.locationName
    }
}
