//
//  RainForecastView.swift
//  WeatherApp
//
//  Created by Rin Sang on 14/07/2022.
//

import UIKit
import MResources
import MUIComponents
import MModels

final class RainForecastView: ParentView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var percentRainLabel: UILabel!
    @IBOutlet private weak var expTimeLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        containerView.layer.cornerRadius = 11
    }

    func setData(data: RainForecastViewData) {
        percentRainLabel.text = data.percentRain
        expTimeLabel.text = "\(data.expTime) PM"
        weatherImageView.image = data.weatherImg
    }
}

struct RainForecastViewData {
    let percentRain: String
    let expTime: String
    let weatherImg: UIImage

    init(weatherDTO: WeatherDTO) {
        let currentWeather = weatherDTO.currentWeather
        percentRain = "\((currentWeather?.rh ?? 0).rounded(.up))%"
        expTime = currentWeather?.date.displayString(.hourMinutes, in: .current, timeZone: .current) ?? ""
        weatherImg = Assets.Weather.rainy.image
    }
}
