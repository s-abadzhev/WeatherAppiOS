//
//  CityRepositoryTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

@MainActor
struct CityRepositoryTests {

    @Test("Поиск города возвращает результаты")
    func searchCity_success_returnsCities() async throws {
        let geocoderService = MockGeocoderService()
        geocoderService.citiesToReturn = [.mock]

        let sut = CityRepositoryImpl(geocoderService: geocoderService)
        let cities = try await sut.searchCity(query: "Москва")

        #expect(cities.count == 1)
    }

    @Test("Reverse geocoding возвращает город")
    func reverseGeocode_success_returnsCity() async throws {
        let geocoderService = MockGeocoderService()
        geocoderService.cityToReturn = .mock

        let sut = CityRepositoryImpl(geocoderService: geocoderService)
        let city = try await sut.reverseGeocode(lat: 55.75, lon: 37.61)

        #expect(city == .mock)
    }

    @Test("Ошибка геокодера пробрасывается наверх")
    func searchCity_error_throws() async {
        let geocoderService = MockGeocoderService()
        geocoderService.errorToThrow = NetworkError.noInternetConnection

        let sut = CityRepositoryImpl(geocoderService: geocoderService)

        await #expect(throws: NetworkError.noInternetConnection) {
            try await sut.searchCity(query: "Москва")
        }
    }
}
