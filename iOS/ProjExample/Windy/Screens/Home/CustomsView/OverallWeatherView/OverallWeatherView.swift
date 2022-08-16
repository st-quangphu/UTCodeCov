//
//  OverallWeatherView.swift
//  Windy
//
//  Created by Long Vo M. on 7/25/22.
//

import UIKit
import MUtility
import MModels
import MapKit
import MUIComponents

class OverallWeatherView: ParentView {

    @IBOutlet private weak var tempertureLabel: UILabel!
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!

    func loadData(data: OverallWeatherViewData) {
        DispatchQueue.main.async {
            self.weatherImage.image = data.weatherType?.weatherImage
            self.locationNameLabel.text = data.placeName
            self.tempertureLabel.text = data.temperture
        }
    }
}

extension OverallWeatherView: SubviewsSetupable {
    func setupSubviews() {
    }
}

struct OverallWeatherViewData: ViewData {
    let weatherType: WeatherType?
    let placeName: String
    let temperture: String

    init(weatherDTO: WeatherDTO) {
        let currentWeather = weatherDTO.currentWeather
        weatherType = currentWeather?.weatherType
        if let placemark = weatherDTO.place?.placemark {
            let city = placemark.locality ?? ""
            let country = placemark.country ?? ""
            placeName = city.isEmpty ? country : city
        } else {
            placeName = ""
        }
        temperture = "\((currentWeather?.temp ?? 0).rounded(.up))"
    }
}
