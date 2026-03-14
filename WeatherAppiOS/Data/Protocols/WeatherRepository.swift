//
//  WeatherRepository.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

protocol WeatherRepository {
    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> Weather
    func fetchForecast(lat: Double, lon: Double) async throws -> (daily: [Forecast], hourly: [HourlyForecast])
    func searchCity(query: String) async throws -> [City]
}
