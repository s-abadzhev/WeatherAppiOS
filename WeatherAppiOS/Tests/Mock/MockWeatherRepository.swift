//
//  MockWeatherRepository.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

final class MockWeatherRepository: WeatherRepository {

    var weatherToReturn: Weather?
    var forecastToReturn: (daily: [Forecast], hourly: [HourlyForecast]) = ([], [])
    var citiesToReturn: [City] = []
    var errorToThrow: Error?

    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> Weather {
        if let error = errorToThrow { throw error }
        return weatherToReturn ?? .mock
    }

    func fetchForecast(lat: Double, lon: Double) async throws -> (daily: [Forecast], hourly: [HourlyForecast]) {
        if let error = errorToThrow { throw error }
        return forecastToReturn
    }

    func searchCity(query: String) async throws -> [City] {
        if let error = errorToThrow { throw error }
        return citiesToReturn
    }
}

extension Weather {
    static let mock = Weather(
        city: .mock,
        temperature: 22.5,
        feelsLike: 21.0,
        humidity: 60,
        windSpeed: 5.4,
        windDirection: 180,
        uvIndex: 3.0,
        visibility: 10000,
        condition: .partlyCloudy,
        updatedAt: Date()
    )
}

extension City {
    static let mock = City(
        name: "Москва",
        country: "Россия",
        latitude: 55.75,
        longitude: 37.61
    )
}
