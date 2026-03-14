//
//  SearchView.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import SwiftUI

struct SearchView: View {

    @State var viewModel: SearchViewModel
    @Environment(\.dismiss) private var dismiss

    let onCitySelected: (City) -> Void

    var body: some View {
        ZStack {
            BackgroundView(condition: nil)

            VStack(spacing: 0) {
                searchBar

                if viewModel.isLoading {
                    loadingView
                } else if !viewModel.results.isEmpty {
                    searchResultsList
                } else if viewModel.query.count >= 2 && !viewModel.isLoading {
                    emptyResultsView
                } else {
                    savedCitiesList
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Subviews

    private var searchBar: some View {
        HStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white.opacity(0.6))

                TextField("", text: $viewModel.query, prompt:
                    Text("Поиск города...")
                        .foregroundStyle(.white.opacity(0.4))
                )
                .foregroundStyle(.white)
                .autocorrectionDisabled()
                .onChange(of: viewModel.query) {
                    viewModel.onQueryChanged()
                }

                if !viewModel.query.isEmpty {
                    Button {
                        viewModel.query = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button("Отмена") {
                dismiss()
            }
            .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    private var searchResultsList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.results) { city in
                    CityRowView(city: city) {
                        viewModel.saveCity(city)
                        onCitySelected(city)
                        dismiss()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private var savedCitiesList: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !viewModel.savedCities.isEmpty {
                Text("Сохранённые города")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.5))
                    .textCase(.uppercase)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.savedCities) { city in
                            CityRowView(city: city, isSaved: true) {
                                onCitySelected(city)
                                dismiss()
                            } onDelete: {
                                viewModel.removeCity(city)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                emptyStateView
            }
        }
    }

    private var loadingView: some View {
        VStack(spacing: 12) {
            Spacer().frame(height: 40)
            ProgressView()
                .tint(.white)
        }
    }

    private var emptyResultsView: some View {
        VStack(spacing: 12) {
            Spacer().frame(height: 40)
            Image(systemName: "magnifyingglass")
                .font(.system(size: 36))
                .foregroundStyle(.white.opacity(0.4))
            Text("Город не найден")
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.5))
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Spacer().frame(height: 60)
            Image(systemName: "mappin.slash")
                .font(.system(size: 36))
                .foregroundStyle(.white.opacity(0.4))
            Text("Начните вводить название города")
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}
