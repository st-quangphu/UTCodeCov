//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Rin Sang on 14/07/2022.
//

import UIKit
import MUtility
import MUIComponents
import MModels

final class WeatherInfoView: ParentView {

    @IBOutlet private weak var aqLabel: UILabel!
    @IBOutlet private weak var rainLabel: UILabel!
    @IBOutlet private weak var uvLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        setupSubviews()
    }

    func loadData(data: WeatherInfoViewData) {
        aqLabel.text = data.aq
        rainLabel.text = data.rain
        uvLabel.text = data.uv
        timeLabel.text = data.time
    }
}

extension WeatherInfoView: SubviewsSetupable {
    func setupSubviews() {
        configView()
    }

    private func configView() {
        containerView.layer.cornerRadius = 11
    }
}

struct WeatherInfoViewData: ViewData {
    let aq: String
    let uv: String
    let rain: String
    let time: String

    init(weatherDTO: WeatherDTO) {
        self.aq = "N/A"
        self.uv = "N/A"
        self.rain = "\((weatherDTO.currentWeather?.rh ?? 0).rounded(.up))%"
        self.time = Date().displayString(.hourMinutes, in: .current, timeZone: .current)
    }
}
