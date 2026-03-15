//
//  City.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct City: Identifiable, Hashable {
    let id: UUID
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double

    init(
        id: UUID = UUID(),
        name: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension City: Equatable {
    public static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
}
