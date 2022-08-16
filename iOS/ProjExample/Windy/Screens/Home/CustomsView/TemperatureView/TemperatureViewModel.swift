//
//  TemperatureViewModel.swift
//  Windy
//
//  Created by Rin Sang on 18/07/2022.
//

import Foundation
protocol TemperatureViewModelType {
    func numberOfItemsInSection() -> Int
}

class TemperatureViewModel {
}

extension TemperatureViewModel: TemperatureViewModelType {
    func numberOfItemsInSection() -> Int {
        3
    }
}
