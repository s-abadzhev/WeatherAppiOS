//
//  WeatherRepositoryTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

@MainActor
struct WeatherRepositoryTests {

    @Test("Успешный запрос возвращает погоду")
    func fetchCurrentWeather_success_returnsWeather() async throws {
        let networkClient = MockNetworkClient()
        let cityRepository = MockCityRepository()
        networkClient.dataToReturn = CurrentWeatherResponseDTO.mock
        cityRepository.cityToReturn = .mock

        let sut = WeatherRepositoryImpl(
            networkClient: networkClient,
            cityRepository: cityRepository
        )

        let weather = try await sut.fetchCurrentWeather(lat: 55.75, lon: 37.61)

        #expect(weather.city == .mock)
        #expect(networkClient.requestCallCount == 1)
    }

    @Test("Ошибка сети пробрасывается наверх")
    func fetchCurrentWeather_networkError_throws() async {
        let networkClient = MockNetworkClient()
        let cityRepository = MockCityRepository()
        networkClient.errorToThrow = NetworkError.noInternetConnection

        let sut = WeatherRepositoryImpl(
            networkClient: networkClient,
            cityRepository: cityRepository
        )

        await #expect(throws: NetworkError.noInternetConnection) {
            try await sut.fetchCurrentWeather(lat: 55.75, lon: 37.61)
        }
    }

    @Test("Запрос прогноза возвращает daily и hourly")
    func fetchForecast_success_returnsBothForecasts() async throws {
        let networkClient = MockNetworkClient()
        networkClient.dataToReturn = ForecastResponseDTO.mock

        let sut = WeatherRepositoryImpl(
            networkClient: networkClient,
            cityRepository: MockCityRepository()
        )

        let forecast = try await sut.fetchForecast(lat: 55.75, lon: 37.61)

        #expect(!forecast.daily.isEmpty)
    }
}
