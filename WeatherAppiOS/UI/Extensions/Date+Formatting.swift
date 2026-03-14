//
//  Date+Formatting.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

extension Date {

    var formattedHour: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    var formattedWeekday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEEE"
        let weekday = formatter.string(from: self).capitalized

        if Calendar.current.isDateInToday(self) { return "Сегодня" }
        if Calendar.current.isDateInTomorrow(self) { return "Завтра" }
        return weekday
    }
}
