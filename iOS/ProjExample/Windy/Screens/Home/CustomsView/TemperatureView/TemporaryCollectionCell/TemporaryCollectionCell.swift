//
//  TemporaryCollectionCell.swift
//  WeatherApp
//
//  Created by Rin Sang on 14/07/2022.
//

import UIKit

final class TemporaryCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var weatherImg: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(data: TemporaryCollectionCellViewData) {
        weatherImg.image = data.weatherImage
        locationLabel.text = data.location
        temperatureLabel.text = "\(data.temperature)"
    }
}

struct TemporaryCollectionCellViewData {
    let weatherImage: UIImage
    let location: String
    let temperature: Int
}
