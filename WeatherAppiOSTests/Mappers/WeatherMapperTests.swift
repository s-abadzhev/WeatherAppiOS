//
//  WeatherMapperTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

struct WeatherMapperTests {

    @Test("Маппинг корректно переносит температуру")
    func toDomain_mapsTemperatureCorrectly() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.temperature == CurrentWeatherResponseDTO.mock.current.temperature2M)
    }

    @Test("Маппинг корректно переносит влажность")
    func toDomain_mapsHumidityCorrectly() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.humidity == CurrentWeatherResponseDTO.mock.current.relativeHumidity2M)
    }

    @Test("Маппинг корректно переносит ощущаемую температуру")
    func toDomain_mapsFeelsLikeCorrectly() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.feelsLike == CurrentWeatherResponseDTO.mock.current.apparentTemperature)
    }

    @Test("Маппинг корректно переносит скорость ветра")
    func toDomain_mapsWindSpeedCorrectly() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.windSpeed == CurrentWeatherResponseDTO.mock.current.windSpeed10M)
    }

    @Test("Маппинг корректно переносит УФ-индекс")
    func toDomain_mapsUVIndexCorrectly() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.uvIndex == CurrentWeatherResponseDTO.mock.current.uvIndex)
    }

    @Test("Маппинг корректно переносит видимость")
    func toDomain_mapsVisibilityCorrectly() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.visibility == CurrentWeatherResponseDTO.mock.current.visibility)
    }

    @Test("Маппинг корректно маппит weather code в condition")
    func toDomain_mapsWeatherCodeToCondition() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        let expected = WeatherConditionMapper.toDomain(code: CurrentWeatherResponseDTO.mock.current.weatherCode)
        #expect(result.condition == expected)
    }

    @Test("Маппинг корректно переносит город")
    func toDomain_mapsCity() {
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        #expect(result.city == .mock)
    }

    @Test("updatedAt устанавливается близко к текущему времени")
    func toDomain_setsUpdatedAtToNow() {
        let before = Date()
        let result = WeatherMapper.toDomain(response: .mock, city: .mock)
        let after = Date()
        #expect(result.updatedAt >= before)
        #expect(result.updatedAt <= after)
    }
}
