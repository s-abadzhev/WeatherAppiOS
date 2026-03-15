//
//  MockCityStorage.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
@testable import WeatherAppiOS

final class MockCityStorage: CityStorage {

    var cities: [City] = []
    private(set) var saveCallCount = 0
    private(set) var loadCallCount = 0

    func saveCities(_ cities: [City]) {
        saveCallCount += 1
        self.cities = cities
    }

    func loadCities() -> [City] {
        loadCallCount += 1
        return cities
    }
}
