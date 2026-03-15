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

    let homeViewModel: HomeViewModel
    let searchViewModel: SearchViewModel

    init() {
        let cityRepository = CityRepositoryImpl()
        let cityStorage = UserDefaultsCityStorage()
        let repository = WeatherRepositoryImpl(cityRepository: cityRepository)
        let locationManager = LocationManager()

        self.homeViewModel = HomeViewModel(repository: repository, locationManager: locationManager)
        self.searchViewModel = SearchViewModel(cityRepository: cityRepository, storage: cityStorage)
    }
}
