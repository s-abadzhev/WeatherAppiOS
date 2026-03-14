//
//  ForecastDTO.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct ForecastResponseDTO: Decodable {
    let daily: DailyDTO
    let hourly: HourlyDTO
}

struct DailyDTO: Decodable {
    let time: [String]
    let temperature2MMax: [Double]
    let temperature2MMin: [Double]
    let precipitationSum: [Double]
    let precipitationProbabilityMax: [Int]
    let weatherCode: [Int]

//    enum CodingKeys: String, CodingKey {
//        case time
//        case temperature2mMax = "temperature_2m_max"
//        case temperature2mMin = "temperature_2m_min"
//        case precipitationSum = "precipitation_sum"
//        case precipitationProbabilityMax = "precipitation_probability_max"
//        case weatherCode = "weather_code"
//    }
}

struct HourlyDTO: Decodable {
    let time: [String]
    let temperature2M: [Double]
    let precipitationProbability: [Int]
    let windSpeed10M: [Double]
    let weatherCode: [Int]

//    enum CodingKeys: String, CodingKey {
//        case time
//        case temperature2m = "temperature_2m"
//        case precipitationProbability = "precipitation_probability"
//        case windSpeed10m = "wind_speed_10m"
//        case weatherCode = "weather_code"
//    }
}
