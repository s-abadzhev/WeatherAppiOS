//
//  CityRepositoryImpl.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 14.03.26.
//

import Foundation

final class CityRepositoryImpl: CityRepository {

    private let geocoderService: GeocoderService

    init(geocoderService: GeocoderService = CLGeocoderService()) {
        self.geocoderService = geocoderService
    }

    func searchCity(query: String) async throws -> [City] {
        try await geocoderService.searchCity(query: query)
    }

    func reverseGeocode(lat: Double, lon: Double) async throws -> City {
        try await geocoderService.reverseGeocode(lat: lat, lon: lon)
    }
}
