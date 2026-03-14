//
//  WeatherCondition.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum WeatherCondition {
    case clearSky
    case partlyCloudy
    case overcast
    case fog
    case drizzle
    case rain
    case snowfall
    case thunderstorm

    var title: String {
        switch self {
        case .clearSky:      return "Ясно"
        case .partlyCloudy:  return "Переменная облачность"
        case .overcast:      return "Пасмурно"
        case .fog:           return "Туман"
        case .drizzle:       return "Морось"
        case .rain:          return "Дождь"
        case .snowfall:      return "Снег"
        case .thunderstorm:  return "Гроза"
        }
    }

    var systemImage: String {
        switch self {
        case .clearSky:      return "sun.max.fill"
        case .partlyCloudy:  return "cloud.sun.fill"
        case .overcast:      return "cloud.fill"
        case .fog:           return "cloud.fog.fill"
        case .drizzle:       return "cloud.drizzle.fill"
        case .rain:          return "cloud.rain.fill"
        case .snowfall:      return "cloud.snow.fill"
        case .thunderstorm:  return "cloud.bolt.rain.fill"
        }
    }
}
