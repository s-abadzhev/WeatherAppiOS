//
//  LocationError.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum LocationError: LocalizedError {
    case permissionDenied
    case permissionRestricted
    case locationUnavailable
    case timeout

    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return L10n.Location.permissionDenied
        case .permissionRestricted:
            return L10n.Location.permissionRestricted
        case .locationUnavailable:
            return L10n.Location.unavailable
        case .timeout:
            return L10n.Location.timeout
        }
    }
}
