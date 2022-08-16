//
//  ListHomeViewModel.swift
//  Windy
//
//  Created by Rin Sang on 09/08/2022.
//

import Foundation
import MModels
import MUtility

public protocol ListHomeViewModelType: ListDataSetupable {
}

final class ListHomeViewModel {
  var bookmarkedWeathers: [WeatherDTO]

  init(bookmarkedWeathers: [WeatherDTO]) {
    self.bookmarkedWeathers = bookmarkedWeathers
  }
}

extension ListHomeViewModel: ListHomeViewModelType {
  func numberOfItems(in section: Int) -> Int {
    bookmarkedWeathers.count
  }

  func cellForItem<T>(at indexPath: IndexPath, cellData: T.Type) -> T? where T: ViewData {
    let bookmarkedWeathers = bookmarkedWeathers[indexPath.row]
    let item = ListHomeCellData(
      locationName: bookmarkedWeathers.locationName,
      temperature: bookmarkedWeathers.temperature,
      weatherImage: UIImage(named: "Sunny"),
      currentTime: "",
      percentRain: bookmarkedWeathers.percentRain
    )
    return item  as? T
  }
}
