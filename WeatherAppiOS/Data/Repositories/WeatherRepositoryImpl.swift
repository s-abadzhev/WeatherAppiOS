//
//  WeatherRepositoryImpl.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

final class WeatherRepositoryImpl: WeatherRepository {

    private let networkClient: NetworkClient
    private let cityRepository: CityRepository

    init(networkClient: NetworkClient = URLSessionNetworkClient.shared,
         cityRepository: CityRepository) {
        self.networkClient = networkClient
        self.cityRepository = cityRepository
    }

    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> Weather {
        let city = try await cityRepository.reverseGeocode(lat: lat, lon: lon)
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

}
