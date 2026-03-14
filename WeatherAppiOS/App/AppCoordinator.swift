//
//  AppCoordinator.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

@MainActor
@Observable
final class AppCoordinator {

    var selectedCity: City?
    var isSearchPresented = false

    let repository: WeatherRepository
    let locationManager: LocationManager
    let cityStorage: CityStorage
    let cityRepository: CityRepository

    init() {
        self.cityRepository = CityRepositoryImpl()
        self.repository = WeatherRepositoryImpl(cityRepository: self.cityRepository)
        self.locationManager = LocationManager()
        self.cityStorage = UserDefaultsCityStorage()
    }
}
