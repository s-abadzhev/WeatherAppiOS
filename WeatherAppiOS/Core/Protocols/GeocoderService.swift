//
//  GeocoderService.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

protocol GeocoderService {
    func reverseGeocode(lat: Double, lon: Double) async throws -> City
    func searchCity(query: String) async throws -> [City]
}
