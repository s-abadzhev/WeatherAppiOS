//
//  Weather.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct Weather {
    let city: City
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let windDirection: Double
    let uvIndex: Double
    let visibility: Double
    let condition: WeatherCondition
    let updatedAt: Date
}

extension Weather: Equatable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.city == rhs.city && lhs.temperature == rhs.temperature
    }
}
