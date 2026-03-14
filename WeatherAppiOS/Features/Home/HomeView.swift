//
//  HomeView.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import SwiftUI

struct HomeView: View {

    @State var viewModel: HomeViewModel
    let selectedCity: City?

    var body: some View {
        ZStack {
            BackgroundView(condition: viewModel.weather?.condition)

            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else if let error = viewModel.error {
                    ErrorView(message: error) {
                        Task { await viewModel.loadWeatherForCurrentLocation() }
                    }
                } else if let weather = viewModel.weather {
                    WeatherContentView(
                        weather: weather,
                        hourlyForecast: viewModel.hourlyForecast,
                        dailyForecast: viewModel.dailyForecast
                    )
                }
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .onChange(of: selectedCity) { _, new in
            guard let new else { return }
            Task { await viewModel.loadWeather(lat: new.latitude, lon: new.longitude) }
        }
    }
}
