//
//  WeatherRepositoryImpl.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

final class WeatherRepositoryImpl: WeatherRepository {

    private let networkClient: NetworkClient
    private let geocoderService: GeocoderService

    init(networkClient: NetworkClient = URLSessionNetworkClient.shared,
         geocoderService: GeocoderService = CLGeocoderService()
    ) {
        self.networkClient = networkClient
        self.geocoderService = geocoderService
    }

    // MARK: - WeatherRepository

    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> Weather {
        let city = try await geocoderService.reverseGeocode(lat: lat, lon: lon)
        let weather: CurrentWeatherResponseDTO = try await networkClient.request(.currentWeather(lat: lat, lon: lon))
        return WeatherMapper.toDomain(response: weather, city: city)
    }

    func fetchForecast(lat: Double, lon: Double) async throws -> (daily: [Forecast], hourly: [HourlyForecast]) {
        let response: ForecastResponseDTO = try await networkClient.request(.forecast(lat: lat, lon: lon))
        return (
            daily: ForecastMapper.toDailyDomain(response: response),
            hourly: ForecastMapper.toHourlyDomain(response: response)
        )
    }

    func searchCity(query: String) async throws -> [City] {
        try await geocoderService.searchCity(query: query)
    }

    // MARK: - Private

//    private func fetchCity(lat: Double, lon: Double) async throws -> City {
//        let query = "\(lat),\(lon)"
//        let results = try await searchCity(query: query)
//
//        return results.first ?? City(
//            name: "Моё местоположение",
//            country: "",
//            latitude: lat,
//            longitude: lon
//        )
//    }
}
