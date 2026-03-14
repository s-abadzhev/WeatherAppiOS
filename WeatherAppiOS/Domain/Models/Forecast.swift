//
//  Forecast.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct Forecast {
    let date: Date
    let tempMin: Double
    let tempMax: Double
    let condition: WeatherCondition
    let precipitationProbability: Int
    let precipitationSum: Double
}
