//
//  HomeViewModelTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
import CoreLocation
@testable import WeatherAppiOS

@MainActor
struct HomeViewModelTests {

    // MARK: - loadWeather

    @Test("Успешная загрузка погоды обновляет состояние")
    func loadWeather_success_updatesState() async {
        let repository = MockWeatherRepository()
        let forecast = (daily: [Forecast.mock], hourly: [HourlyForecast.mock])
        repository.weatherToReturn = .mock
        repository.forecastToReturn = forecast

        let sut = makeViewModel(repository: repository)
        await sut.loadWeather(lat: 55.75, lon: 37.61)

        #expect(sut.weather == .mock)
        #expect(sut.dailyForecast.count == 1)
        #expect(sut.hourlyForecast.count == 1)
        #expect(sut.isLoading == false)
        #expect(sut.error == nil)
    }

    @Test("Ошибка сети устанавливает сообщение об ошибке")
    func loadWeather_networkError_setsError() async {
        let repository = MockWeatherRepository()
        repository.errorToThrow = NetworkError.noInternetConnection

        let sut = makeViewModel(repository: repository)
        await sut.loadWeather(lat: 55.75, lon: 37.61)

        #expect(sut.error != nil)
        #expect(sut.weather == nil)
        #expect(sut.isLoading == false)
    }

    @Test("isLoading сбрасывается после загрузки")
    func loadWeather_always_resetsLoading() async {
        let repository = MockWeatherRepository()
        repository.errorToThrow = NetworkError.timeout

        let sut = makeViewModel(repository: repository)
        await sut.loadWeather(lat: 55.75, lon: 37.61)

        #expect(sut.isLoading == false)
    }

    @Test("Повторная загрузка сбрасывает предыдущую ошибку")
    func loadWeather_retry_clearsError() async {
        let repository = MockWeatherRepository()
        repository.errorToThrow = NetworkError.noInternetConnection

        let sut = makeViewModel(repository: repository)
        await sut.loadWeather(lat: 55.75, lon: 37.61)
        #expect(sut.error != nil)

        repository.errorToThrow = nil
        await sut.loadWeather(lat: 55.75, lon: 37.61)
        #expect(sut.error == nil)
    }

    @Test("Загрузка погоды вызывает оба запроса параллельно")
    func loadWeather_callsBothRepositoryMethods() async {
        let repository = MockWeatherRepository()
        let sut = makeViewModel(repository: repository)

        await sut.loadWeather(lat: 55.75, lon: 37.61)

        #expect(repository.fetchWeatherCallCount == 1)
        #expect(repository.fetchForecastCallCount == 1)
    }

    @Test("Загрузка с правильными координатами")
    func loadWeather_passesCorrectCoordinates() async {
        let repository = MockWeatherRepository()
        let sut = makeViewModel(repository: repository)

        await sut.loadWeather(lat: 55.75, lon: 37.61)

        #expect(repository.lastFetchedLat == 55.75)
        #expect(repository.lastFetchedLon == 37.61)
    }

    // MARK: - Helpers

    private func makeViewModel(
        repository: MockWeatherRepository = MockWeatherRepository()
    ) -> HomeViewModel {
        HomeViewModel(
            repository: repository,
            locationManager: LocationManager()
        )
    }
}
