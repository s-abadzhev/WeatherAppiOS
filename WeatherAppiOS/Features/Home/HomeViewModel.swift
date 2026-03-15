//
//  HomeViewModel.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation
import CoreLocation

@Observable
@MainActor
final class HomeViewModel {

    var weather: Weather?
    var dailyForecast: [Forecast] = []
    var hourlyForecast: [HourlyForecast] = []
    var isLoading = false
    var error: String?

    private let repository: WeatherRepository
    private let locationManager: LocationManager

    init(
        repository: WeatherRepository,
        locationManager: LocationManager
    ) {
        self.repository = repository
        self.locationManager = locationManager
    }

    func onAppear() async {
        await loadWeatherForCurrentLocation()
    }

    func loadWeatherForCurrentLocation() async {
        isLoading = true
        error = nil
        defer { isLoading = false }

        do {
            let location = try await locationManager.requestLocation()
            await loadWeather(
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            )
        } catch {
            self.error = error.localizedDescription
        }
    }

    func loadWeather(lat: Double, lon: Double) async {
        error = nil
        do {
            async let weatherRequest = repository.fetchCurrentWeather(lat: lat, lon: lon)
            async let forecastRequest = repository.fetchForecast(lat: lat, lon: lon)

            let (weather, forecast) = try await (weatherRequest, forecastRequest)

            self.weather = weather
            self.dailyForecast = forecast.daily
            self.hourlyForecast = forecast.hourly
        } catch {
            self.error = error.localizedDescription
        }
    }
}

