//
//  LocationStatus.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum LocationStatus {
    case idle
    case loading
    case authorized
    case denied
    case failed

    var isDenied: Bool {
        self == .denied
    }
}
