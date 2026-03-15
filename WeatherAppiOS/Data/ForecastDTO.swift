//
//  ForecastDTO.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct ForecastResponseDTO: Decodable, Sendable {
    let daily: DailyDTO
    let hourly: HourlyDTO
}

struct DailyDTO: Decodable, Sendable {
    let time: [String]
    let temperature2MMax: [Double]
    let temperature2MMin: [Double]
    let precipitationSum: [Double]
    let precipitationProbabilityMax: [Int]
    let weatherCode: [Int]
}

struct HourlyDTO: Decodable, Sendable {
    let time: [String]
    let temperature2M: [Double]
    let precipitationProbability: [Int]
    let windSpeed10M: [Double]
    let weatherCode: [Int]
}
