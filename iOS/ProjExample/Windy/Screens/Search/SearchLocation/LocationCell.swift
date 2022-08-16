//
//  LocationCell.swift
//  Windy
//
//  Created by Rin Sang on 18/07/2022.
//

import UIKit
import MModels
import MapKit
import MUtility

final class LocationCell: UITableViewCell {
    @IBOutlet private weak var waringStackView: UIStackView!
    @IBOutlet private weak var weatherTypeLabel: UILabel!
    @IBOutlet private weak var contenView: UIView!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        selectionStyle = .none
        contenView.layer.cornerRadius = 11
    }

    func loadData(viewData: LocationCellViewData?) {
        guard let viewData = viewData else {
            return
        }
        nameLocationLabel.text = viewData.placeName
        temperatureLabel.text = viewData.temperature
        weatherImageView.image = viewData.weatherType?.weatherImage
        weatherTypeLabel.text = viewData.weatherType?.rawValue
        waringStackView.isHidden = (viewData.weatherType != .rainy)
    }
}

struct LocationCellViewData: ViewData {
    let placeName: String?
    let temperature: String
    let weatherType: WeatherType?

    init(weatherDTO: WeatherDTO) {
        let currentWeather = weatherDTO.currentWeather
        placeName = weatherDTO.locationName
        temperature = "\((currentWeather?.temp ?? 0.0).rounded(.up))"
        weatherType = currentWeather?.weatherType
    }
}
