//
//  Double+Formatting.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

extension Double {

    var formattedTemp: String {
        let rounded = Int(rounded())
        return "\(rounded)°"
    }

    var formattedVisibility: String {
        if self >= 1000 {
            return "\(Int(self / 1000)) км"
        }
        return "\(Int(self)) м"
    }

    var formattedUV: String {
        switch self {
        case 0..<3:  return "Низкий"
        case 3..<6:  return "Умеренный"
        case 6..<8:  return "Высокий"
        case 8..<11: return "Очень высокий"
        default:     return "Экстремальный"
        }
    }
}
