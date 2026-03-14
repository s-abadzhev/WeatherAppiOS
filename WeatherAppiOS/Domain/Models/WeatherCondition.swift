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
        case .clearSky:     return L10n.Weather.clearSky
        case .partlyCloudy: return L10n.Weather.partlyCloudy
        case .overcast:     return L10n.Weather.overcast
        case .fog:          return L10n.Weather.fog
        case .drizzle:      return L10n.Weather.drizzle
        case .rain:         return L10n.Weather.rain
        case .snowfall:     return L10n.Weather.snowfall
        case .thunderstorm: return L10n.Weather.thunderstorm
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
