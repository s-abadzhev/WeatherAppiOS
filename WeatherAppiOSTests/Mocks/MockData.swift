//
//  MockData.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
@testable import WeatherAppiOS

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

extension Forecast {
    static let mock = Forecast(
        date: Date(),
        tempMin: 15.0,
        tempMax: 25.0,
        condition: .clearSky,
        precipitationProbability: 10,
        precipitationSum: 0.0
    )
}

extension HourlyForecast {
    static let mock = HourlyForecast(
        date: Date().addingTimeInterval(3600),
        temperature: 22.0,
        condition: .clearSky,
        precipitationProbability: 5,
        windSpeed: 3.0
    )
}

extension CurrentWeatherResponseDTO {
    static let mock = CurrentWeatherResponseDTO(
        current: CurrentWeatherDTO(
            temperature2M: 22.5,
            relativeHumidity2M: 60,
            apparentTemperature: 21.0,
            windSpeed10M: 5.4,
            windDirection10M: 180,
            uvIndex: 3.0,
            visibility: 10000,
            weatherCode: 0
        )
    )

    static let mockJSON: Data = {
        let json = """
        {
            "current": {
                "temperature_2m": 22.5,
                "relative_humidity_2m": 60,
                "apparent_temperature": 21.0,
                "wind_speed_10m": 5.4,
                "wind_direction_10m": 180.0,
                "uv_index": 3.0,
                "visibility": 10000.0,
                "weather_code": 0
            }
        }
        """
        return json.data(using: .utf8)!
    }()
}

extension ForecastResponseDTO {
    static let mock = ForecastResponseDTO(
        daily: DailyDTO(
            time: ["2026-03-15", "2026-03-16"],
            temperature2MMax: [25.0, 23.0],
            temperature2MMin: [15.0, 14.0],
            precipitationSum: [0.0, 2.5],
            precipitationProbabilityMax: [10, 30],
            weatherCode: [0, 61]
        ),
        hourly: HourlyDTO(
            time: [
                Date().addingTimeInterval(3600).ISO8601Format(),
                Date().addingTimeInterval(7200).ISO8601Format()
            ],
            temperature2M: [22.0, 21.0],
            precipitationProbability: [5, 10],
            windSpeed10M: [3.0, 4.0],
            weatherCode: [0, 1]
        )
    )

    static let empty = ForecastResponseDTO(
        daily: DailyDTO(
            time: [],
            temperature2MMax: [],
            temperature2MMin: [],
            precipitationSum: [],
            precipitationProbabilityMax: [],
            weatherCode: []
        ),
        hourly: HourlyDTO(
            time: [],
            temperature2M: [],
            precipitationProbability: [],
            windSpeed10M: [],
            weatherCode: []
        )
    )
}
