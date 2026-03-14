//
//  CurrentWeatherDTO.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct CurrentWeatherResponseDTO: Decodable {
    let current: CurrentWeatherDTO
}

struct CurrentWeatherDTO: Decodable {
    let temperature2M: Double
    let relativeHumidity2M: Int
    let apparentTemperature: Double
    let windSpeed10M: Double
    let windDirection10M: Double
    let uvIndex: Double
    let visibility: Double
    let weatherCode: Int
}
