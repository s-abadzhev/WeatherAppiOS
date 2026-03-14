//
//  WeatherDetailsView.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import SwiftUI

struct WeatherDetailsView: View {

    let weather: Weather

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            DetailCard(
                icon: "humidity.fill",
                title: "Влажность",
                value: "\(weather.humidity)%"
            )
            DetailCard(
                icon: "wind",
                title: "Ветер",
                value: "\(weather.windSpeed.formatted(.number.precision(.fractionLength(1)))) м/с"
            )
            DetailCard(
                icon: "sun.max.fill",
                title: "УФ-индекс",
                value: weather.uvIndex.formattedUV
            )
            DetailCard(
                icon: "eye.fill",
                title: "Видимость",
                value: weather.visibility.formattedVisibility
            )
        }
    }
}
