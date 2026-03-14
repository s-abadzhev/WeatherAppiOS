//
//  MockGeocoderService.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

final class MockGeocoderService: GeocoderService {

    var cityToReturn: City = .mock
    var citiesToReturn: [City] = []
    var errorToThrow: Error?

    func reverseGeocode(lat: Double, lon: Double) async throws -> City {
        if let error = errorToThrow { throw error }
        return cityToReturn
    }

    func searchCity(query: String) async throws -> [City] {
        if let error = errorToThrow { throw error }
        return citiesToReturn
    }
}
