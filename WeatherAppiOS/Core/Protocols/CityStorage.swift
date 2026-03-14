//
//  CityStorage.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

protocol CityStorage {
    func saveCities(_ cities: [City])
    func loadCities() -> [City]
}
