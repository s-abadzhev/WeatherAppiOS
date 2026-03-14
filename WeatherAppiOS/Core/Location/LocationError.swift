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
            return "Доступ к геолокации запрещён. Разрешите доступ в Настройках."
        case .permissionRestricted:
            return "Доступ к геолокации ограничен."
        case .locationUnavailable:
            return "Не удалось определить местоположение."
        case .timeout:
            return "Превышено время ожидания геолокации."
        }
    }
}
