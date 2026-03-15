//
//  MockCityRepository.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
@testable import WeatherAppiOS

final class MockCityRepository: CityRepository {

    var citiesToReturn: [City] = []
    var cityToReturn: City = .mock
    var errorToThrow: Error?

    private(set) var searchCallCount = 0
    private(set) var lastSearchQuery: String?
    private(set) var reverseGeocodeCallCount = 0

    func searchCity(query: String) async throws -> [City] {
        searchCallCount += 1
        lastSearchQuery = query
        if let error = errorToThrow { throw error }
        return citiesToReturn
    }

    func reverseGeocode(lat: Double, lon: Double) async throws -> City {
        reverseGeocodeCallCount += 1
        if let error = errorToThrow { throw error }
        return cityToReturn
    }
}
