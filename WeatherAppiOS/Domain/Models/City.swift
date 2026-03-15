//
//  City.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

struct City: Identifiable, Hashable, Equatable {
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double

    var id: String { "\(name)_\(country)" }

    public static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

