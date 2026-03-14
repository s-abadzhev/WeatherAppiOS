//
//  HourlyForecast.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct HourlyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
    let condition: WeatherCondition
    let precipitationProbability: Int
    let windSpeed: Double
}
