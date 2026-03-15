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
        HomeView(viewModel: coordinator.homeViewModel, selectedCity: coordinator.selectedCity)
            .overlay(alignment: .topTrailing) {
                searchButton
            }
            .fullScreenCover(isPresented: $coordinator.isSearchPresented) {
                SearchView(viewModel: coordinator.searchViewModel) { city in
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
