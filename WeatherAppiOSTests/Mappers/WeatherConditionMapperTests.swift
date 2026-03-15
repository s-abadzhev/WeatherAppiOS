//
//  WeatherConditionMapperTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

struct WeatherConditionMapperTests {

    @Test("WMO код 0 маппится в clearSky", arguments: [0])
    func clearSky(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .clearSky)
    }

    @Test("WMO коды 1-2 маппятся в partlyCloudy", arguments: [1, 2])
    func partlyCloudy(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .partlyCloudy)
    }

    @Test("WMO код 3 маппится в overcast", arguments: [3])
    func overcast(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .overcast)
    }

    @Test("WMO коды тумана маппятся в fog", arguments: [45, 48])
    func fog(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .fog)
    }

    @Test("WMO коды мороси маппятся в drizzle", arguments: [51, 53, 55, 56, 57])
    func drizzle(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .drizzle)
    }

    @Test("WMO коды дождя маппятся в rain", arguments: [61, 63, 65, 66, 67, 80, 81, 82])
    func rain(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .rain)
    }

    @Test("WMO коды снега маппятся в snowfall", arguments: [71, 73, 75, 77, 85, 86])
    func snowfall(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .snowfall)
    }

    @Test("WMO коды грозы маппятся в thunderstorm", arguments: [95, 96, 99])
    func thunderstorm(code: Int) {
        #expect(WeatherConditionMapper.toDomain(code: code) == .thunderstorm)
    }

    @Test("Неизвестный код маппится в clearSky по умолчанию")
    func unknownCode_defaultsToClearSky() {
        #expect(WeatherConditionMapper.toDomain(code: 999) == .clearSky)
    }
}
