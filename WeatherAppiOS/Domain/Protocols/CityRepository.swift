//
//  CityRepository.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

protocol CityRepository {
    func searchCity(query: String) async throws -> [City]
    func reverseGeocode(lat: Double, lon: Double) async throws -> City
}
