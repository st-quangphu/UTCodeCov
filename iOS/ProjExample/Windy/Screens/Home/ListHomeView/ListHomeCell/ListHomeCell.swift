//
//  ListHomeCell.swift
//  WindyDev
//
//  Created by Rin Sang on 08/08/2022.
//

import UIKit
import MModels
import MapKit
import MUtility

final class ListHomeCell: UITableViewCell {

    @IBOutlet private weak var contenView: UIView!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var percentRainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        selectionStyle = .none
        contenView.layer.cornerRadius = 15
    }

    func loadData(viewData: ListHomeCellData?) {
      guard let viewData = viewData else {
          return
      }
        nameLocationLabel.text = viewData.locationName
        temperatureLabel.text = "\(viewData.temperature ?? 0)"
        weatherImageView.image = viewData.weatherImage
        currentTimeLabel.text = viewData.currentTime
        percentRainLabel.text = "% RAIN: \(viewData.percentRain ?? 0)%"
    }
}

public struct ListHomeCellData: ViewData {
    let locationName: String?
    let temperature: Int?
    let weatherImage: UIImage?
    let currentTime: String?
    let percentRain: Int?
}
