//
//  APIEndpoint.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum APIEndpoint {
    case currentWeather(lat: Double, lon: Double)
    case forecast(lat: Double, lon: Double)

    var path: String {
        return "/forecast"
    }

    private var baseURL: String {
        return "https://api.open-meteo.com/v1"
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .currentWeather(let lat, let lon):
            return [
                .init(name: "latitude", value: "\(lat)"),
                .init(name: "longitude", value: "\(lon)"),
                .init(name: "current", value: "temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,wind_direction_10m,uv_index,visibility,weather_code"),
                .init(name: "timezone", value: "auto")
            ]
        case .forecast(let lat, let lon):
            return [
                .init(name: "latitude", value: "\(lat)"),
                .init(name: "longitude", value: "\(lon)"),
                .init(name: "daily", value: "temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max,weather_code"),
                .init(name: "hourly", value: "temperature_2m,precipitation_probability,wind_speed_10m,weather_code"),
                .init(name: "forecast_days", value: "7"),
                .init(name: "timezone", value: "auto")
            ]
        }
    }

    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
