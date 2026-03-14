//
//  WeatherConditionMapper.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum WeatherConditionMapper {

    static func toDomain(code: Int) -> WeatherCondition {
        switch code {
        case 0:
            return .clearSky
        case 1, 2:
            return .partlyCloudy
        case 3:
            return .overcast
        case 45, 48:
            return .fog
        case 51, 53, 55, 56, 57:
            return .drizzle
        case 61, 63, 65, 66, 67, 80, 81, 82:
            return .rain
        case 71, 73, 75, 77, 85, 86:
            return .snowfall
        case 95, 96, 99:
            return .thunderstorm
        default:
            return .clearSky
        }
    }
}
