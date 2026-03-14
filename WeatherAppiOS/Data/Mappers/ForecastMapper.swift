//
//  ForecastMapper.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum ForecastMapper {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private static let hourlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return formatter
    }()

    static func toDailyDomain(response: ForecastResponseDTO) -> [Forecast] {
        let daily = response.daily

        return daily.time.indices.compactMap { index in
            guard
                let date = dateFormatter.date(from: daily.time[index]),
                index < daily.temperature2MMax.count,
                index < daily.temperature2MMin.count,
                index < daily.precipitationSum.count,
                index < daily.precipitationProbabilityMax.count,
                index < daily.weatherCode.count
            else { return nil }

            return Forecast(
                date: date,
                tempMin: daily.temperature2MMin[index],
                tempMax: daily.temperature2MMax[index],
                condition: WeatherConditionMapper.toDomain(code: daily.weatherCode[index]),
                precipitationProbability: daily.precipitationProbabilityMax[index],
                precipitationSum: daily.precipitationSum[index]
            )
        }
    }

    static func toHourlyDomain(response: ForecastResponseDTO) -> [HourlyForecast] {
        let hourly = response.hourly

        let now = Date()
        let next24Hours = now.addingTimeInterval(24 * 60 * 60)

        return hourly.time.indices.compactMap { index in
            guard
                let date = hourlyDateFormatter.date(from: hourly.time[index]),
                date >= now && date <= next24Hours,
                index < hourly.temperature2M.count,
                index < hourly.precipitationProbability.count,
                index < hourly.windSpeed10M.count,
                index < hourly.weatherCode.count
            else { return nil }

            return HourlyForecast(
                date: date,
                temperature: hourly.temperature2M[index],
                condition: WeatherConditionMapper.toDomain(code: hourly.weatherCode[index]),
                precipitationProbability: hourly.precipitationProbability[index],
                windSpeed: hourly.windSpeed10M[index]
            )
        }
    }
}
