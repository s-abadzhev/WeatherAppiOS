//
//  RootView.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import SwiftUI

struct RootView: View {

    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        @Bindable var coordinator = coordinator
        HomeView(viewModel: HomeViewModel(
            repository: coordinator.repository,
            locationManager: coordinator.locationManager
        ), selectedCity: coordinator.selectedCity)
            .overlay(alignment: .topTrailing) {
                searchButton
            }
            .fullScreenCover(isPresented: $coordinator.isSearchPresented) {
                SearchView(viewModel: SearchViewModel(
                    repository: coordinator.repository,
                    storage: coordinator.cityStorage
                )) { city in
                    coordinator.selectedCity = city
                }
            }
    }

    private var searchButton: some View {
        Button {
            coordinator.isSearchPresented = true
        } label: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.white)
                .padding(12)
                .background(.ultraThinMaterial.opacity(0.6))
                .clipShape(Circle())
        }
        .padding(.top, 16)
        .padding(.trailing, 16)
    }
}
