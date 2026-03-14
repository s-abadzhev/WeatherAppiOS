//
//  WeatherMapper.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum WeatherMapper {

    static func toDomain(
        response: CurrentWeatherResponseDTO,
        city: City
    ) -> Weather {
        let dto = response.current
        return Weather(
            city: city,
            temperature: dto.temperature2M,
            feelsLike: dto.apparentTemperature,
            humidity: dto.relativeHumidity2M,
            windSpeed: dto.windSpeed10M,
            windDirection: dto.windDirection10M,
            uvIndex: dto.uvIndex,
            visibility: dto.visibility,
            condition: WeatherConditionMapper.toDomain(code: dto.weatherCode),
            updatedAt: Date()
        )
    }
}
