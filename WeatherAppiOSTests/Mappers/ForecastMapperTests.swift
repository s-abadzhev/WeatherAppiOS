//
//  ForecastMapperTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

struct ForecastMapperTests {

    @Test("Daily маппинг возвращает правильное количество элементов")
    func toDailyDomain_returnsCorrectCount() {
        let response = ForecastResponseDTO.mock
        let result = ForecastMapper.toDailyDomain(response: response)
        #expect(result.count == response.daily.time.count)
    }

    @Test("Daily маппинг корректно маппит температуры")
    func toDailyDomain_mapsTemperaturesCorrectly() {
        let response = ForecastResponseDTO.mock
        let result = ForecastMapper.toDailyDomain(response: response)

        #expect(result.first?.tempMax == response.daily.temperature2MMax.first)
        #expect(result.first?.tempMin == response.daily.temperature2MMin.first)
    }

    @Test("Hourly маппинг возвращает только следующие 24 часа")
    func toHourlyDomain_returnsOnly24Hours() {
        let response = ForecastResponseDTO.mock
        let result = ForecastMapper.toHourlyDomain(response: response)
        result.forEach { item in
            #expect(item.date >= Date())
            #expect(item.date <= Date().addingTimeInterval(24 * 60 * 60))
        }
    }

    @Test("Пустой ответ возвращает пустой массив")
    func toDailyDomain_emptyResponse_returnsEmpty() {
        let response = ForecastResponseDTO.empty
        let result = ForecastMapper.toDailyDomain(response: response)
        #expect(result.isEmpty)
    }
}
