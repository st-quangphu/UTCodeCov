//
//  WeatherRecord+DTO.swift
//  MService
//
//  Created by Quang Phu C. M. on 7/28/22.
//

import Foundation
import MModels
import CoreData

extension WeatherDTO: CDRecordable {
  public static var entityName: String {
    "Weather"
  }

  public var uniquePredicate: NSPredicate? {
    NSPredicate(format: "name = %@", self.locationName)
  }

  public init(record: CDRecord) {
    // parse data from record
    self.init(
      ts: [],
      units: nil,
      typeSurface: [],
      temp: [],
      mclouds: [],
      rh: []
    )
    locationName = record.value(forKey: "name") as? String ?? ""
    lat = record.value(forKey: "lat") as? Float ?? 0.0
    long = record.value(forKey: "long") as? Float ?? 0.0
    temperature = record.value(forKey: "temperature") as? Int ?? 0
    percentRain = record.value(forKey: "percent_rain") as? Int ?? 0
  }

  public func save(db: DatabaseWriter) {
    guard let entity = NSEntityDescription.entity(forEntityName: WeatherDTO.entityName, in: db) else {
      return
    }
    let record = CDRecord(entity: entity, insertInto: db)
    record.setValue(lat, forKey: "lat")
    record.setValue(long, forKey: "long")
    record.setValue(locationName, forKey: "name")
    record.setValue(temperature, forKey: "temperature")
    record.setValue(percentRain, forKey: "percent_rain")
  }
}
