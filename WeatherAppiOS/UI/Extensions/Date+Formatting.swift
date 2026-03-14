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
        if Calendar.current.isDateInToday(self) { return L10n.Forecast.today }
        if Calendar.current.isDateInTomorrow(self) { return L10n.Forecast.tomorrow }

        let formatter = DateFormatter()
        formatter.locale = Locale.current // автоматически подхватывает язык системы
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self).capitalized
    }
}
