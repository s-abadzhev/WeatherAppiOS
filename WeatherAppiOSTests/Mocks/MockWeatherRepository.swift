//
//  MockWeatherRepository.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
@testable import WeatherAppiOS

final class MockWeatherRepository: WeatherRepository {

    var weatherToReturn: Weather = .mock
    var forecastToReturn: (daily: [Forecast], hourly: [HourlyForecast]) = ([], [])
    var errorToThrow: Error?

    private(set) var fetchWeatherCallCount = 0
    private(set) var fetchForecastCallCount = 0
    private(set) var lastFetchedLat: Double?
    private(set) var lastFetchedLon: Double?

    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> Weather {
        fetchWeatherCallCount += 1
        lastFetchedLat = lat
        lastFetchedLon = lon
        if let error = errorToThrow { throw error }
        return weatherToReturn
    }

    func fetchForecast(lat: Double, lon: Double) async throws -> (daily: [Forecast], hourly: [HourlyForecast]) {
        fetchForecastCallCount += 1
        if let error = errorToThrow { throw error }
        return forecastToReturn
    }
}
