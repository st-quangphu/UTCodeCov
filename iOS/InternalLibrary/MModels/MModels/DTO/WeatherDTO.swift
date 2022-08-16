//
//  WeatherDTO.swift
//  MModels
//
//  Created by Long Vo M. on 7/13/22.
//

import Foundation
import MUtility
import MResources
import MapKit

public struct WeatherDTO: Codable {
    @DecodableDefault.EmptyList public var ts: [Int]
    public var units: WeatherUnitDTO?
    @DecodableDefault.EmptyList public var typeSurface: [Int]
    @DecodableDefault.EmptyList public var temp: [Float]
    @DecodableDefault.EmptyList public var mclouds: [Float]
    @DecodableDefault.EmptyList public var rh: [Float]

    public init(
        ts: [Int],
        units: WeatherUnitDTO?,
        typeSurface: [Int],
        temp: [Float],
        mclouds: [Float],
        rh: [Float]
    ) {
        self.ts = ts
        self.units = units
        self.typeSurface = typeSurface
        self.temp = temp
        self.mclouds = mclouds
        self.rh = rh
    }

    public init() {
        self.ts = []
        self.units = nil
        self.typeSurface = []
        self.temp = []
        self.mclouds = []
        self.rh = []
    }

    public var place: MKMapItem?
    public var long: Float = 0
    public var lat: Float = 0
    public var locationName: String = ""
    public var temperature: Int = 0
    public var percentRain: Int = 0

    enum CodingKeys: String, CodingKey, Equatable {
        case typeSurface = "ptype-surface"
        case temp = "temp-surface"
        case mclouds = "mclouds-surface"
        case ts
        case units
        case rh = "rh-surface" // Relative humidity of air
    }

    public var weatherTimeline: [WeatherCondition] {
        var weatherConditions: [WeatherCondition] = []
        for (index, item) in self.ts.enumerated() {
            let weatherCondition = WeatherCondition(date: item.toDate(),
                                                    typeSurface: typeSurface[index],
                                                    temp: temp[index] - 273.15, // kelvin to Celsius
                                                    mclouds: mclouds[index],
                                                    rh: rh[index])
            weatherConditions.append(weatherCondition)
        }
        return weatherConditions
    }

    public var currentWeather: WeatherCondition? {
        let currentDate = Date()
        if let index = self.weatherTimeline.lastIndex(where: { currentDate >= $0.date }) {
            return weatherTimeline[safe: index]
        }
        return nil
    }

    public mutating func addLocation(place: MKMapItem) -> Self {
      self.place = place
      long = Float(place.placemark.coordinate.longitude)
      lat = Float(place.placemark.coordinate.latitude)
      locationName = place.name ?? ""
      temperature = Int(currentWeather?.temp ?? 0)
      percentRain = Int(currentWeather?.rh ?? 0)
      return self
    }
}

extension WeatherDTO {
    public struct Request {
        public var place: MKMapItem
        public let model: String
        public let parameters: [String]
        public let key: String

        public init(
            _ place: MKMapItem,
            _ model: String,
            _ parameters: [String],
            _ key: String
        ) {
            self.place = place
            self.model = model
            self.parameters = parameters
            self.key = key
        }

        public var params: [String: Any] {
            [
                "lat": Float(place.placemark.coordinate.latitude),
                "lon": Float(place.placemark.coordinate.longitude),
                "model": model,
                "parameters": parameters,
                "key": key
            ]
        }
    }
}


public struct WeatherUnitDTO: Codable {
    @DecodableDefault.EmptyString public var typeSurface: String
    @DecodableDefault.EmptyString public var temp: String
    @DecodableDefault.EmptyString public var mclouds: String

    enum CodingKeys: String, CodingKey, Equatable {
        case typeSurface = "ptype-surface"
        case temp = "temp-surface"
        case mclouds = "mclouds-surface"
    }

    public init(
        typeSurface: String,
        temp: String,
        mclouds: String
    ) {
        self.typeSurface = typeSurface
        self.temp = temp
        self.mclouds = mclouds
    }
}

public struct WeatherCondition {
    public let date: Date
    public let typeSurface: Int
    public let temp: Float
    public let mclouds: Float
    public let rh: Float


    public init(
        date: Date,
        typeSurface: Int,
        temp: Float,
        mclouds: Float,
        rh: Float
    ) {
        self.date = date
        self.typeSurface = typeSurface
        self.temp = temp
        self.mclouds = mclouds
        self.rh = rh
    }

    public var weatherType: WeatherType {
        if typeSurface == 0 && mclouds < 20 {
            return .sunny
        }

        if typeSurface == 1 || typeSurface == 3 {
            return .rainy
        }

        if typeSurface == 0 && mclouds < 60 || mclouds > 20 {
            return .cloudy
        }

        return .normal
    }
}

public enum WeatherType: String {
    case sunny
    case cloudy
    case rainy
    case normal

    public var weatherImage: UIImage {
        switch self {
        case .sunny, .normal:
            return Assets.Weather.sunny.image

        case .rainy:
            return Assets.Weather.rainy.image

        case .cloudy:
            return Assets.Weather.cloudy.image
        }
    }
}
