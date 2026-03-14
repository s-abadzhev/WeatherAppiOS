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

//    enum CodingKeys: String, CodingKey {
//        case temperature2m = "temperature_2m"
//        case relativeHumidity2m = "relative_humidity_2m"
//        case apparentTemperature = "apparent_temperature"
//        case windSpeed10m = "wind_speed_10m"
//        case windDirection10m = "wind_direction_10m"
//        case uvIndex = "uv_index"
//        case visibility
//        case weatherCode = "weather_code"
//    }
}
