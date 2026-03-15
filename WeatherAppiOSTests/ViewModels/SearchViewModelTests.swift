//
//  SearchViewModelTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

@MainActor
struct SearchViewModelTests {

    // MARK: - Search

    @Test("Поиск с коротким запросом не вызывает API")
    func search_shortQuery_doesNotCallAPI() async {
        let cityRepository = MockCityRepository()
        let sut = makeViewModel(cityRepository: cityRepository)

        sut.query = "М"
        sut.onQueryChanged()
        try? await Task.sleep(nanoseconds: 500_000_000)

        #expect(cityRepository.searchCallCount == 0)
        #expect(sut.results.isEmpty)
    }

    @Test("Успешный поиск обновляет результаты")
    func search_success_updatesResults() async throws {
        let cityRepository = MockCityRepository()
        cityRepository.citiesToReturn = [.mock]
        let sut = makeViewModel(cityRepository: cityRepository)

        sut.query = "Москва"
        sut.onQueryChanged()
        try await Task.sleep(nanoseconds: 500_000_000)

        #expect(sut.results.count == 1)
        #expect(sut.isLoading == false)
    }

    @Test("Ошибка поиска очищает результаты")
    func search_error_clearsResults() async throws {
        let cityRepository = MockCityRepository()
        cityRepository.citiesToReturn = [.mock]
        let sut = makeViewModel(cityRepository: cityRepository)

        sut.query = "Москва"
        sut.onQueryChanged()
        try await Task.sleep(nanoseconds: 500_000_000)
        #expect(sut.results.count == 1)

        cityRepository.errorToThrow = NetworkError.noInternetConnection
        sut.query = "Питер"
        sut.onQueryChanged()
        try await Task.sleep(nanoseconds: 500_000_000)

        #expect(sut.results.isEmpty)
        #expect(sut.error != nil)
    }

    // MARK: - Saved Cities

    @Test("Сохранение города добавляет его в список")
    func saveCity_addsToSavedCities() {
        let storage = MockCityStorage()
        let sut = makeViewModel(storage: storage)

        sut.saveCity(.mock)

        #expect(sut.savedCities.count == 1)
        #expect(storage.saveCallCount == 1)
    }

    @Test("Сохранение дубликата не добавляет город повторно")
    func saveCity_duplicate_doesNotAdd() {
        let storage = MockCityStorage()
        let sut = makeViewModel(storage: storage)

        sut.saveCity(.mock)
        sut.saveCity(.mock)

        #expect(sut.savedCities.count == 1)
    }

    @Test("Удаление города убирает его из списка")
    func removeCity_removesFromSavedCities() {
        let storage = MockCityStorage()
        let sut = makeViewModel(storage: storage)

        sut.saveCity(.mock)
        #expect(sut.savedCities.count == 1)

        sut.removeCity(.mock)

        #expect(sut.savedCities.isEmpty)
        #expect(storage.saveCallCount == 2)
    }

    @Test("Загрузка городов при инициализации")
    func init_loadsSavedCities() {
        let storage = MockCityStorage()
        storage.cities = [.mock]

        let sut = makeViewModel(storage: storage)

        #expect(sut.savedCities.count == 1)
        #expect(storage.loadCallCount == 1)
    }

    // MARK: - Helpers

    private func makeViewModel(
        cityRepository: MockCityRepository = MockCityRepository(),
        storage: MockCityStorage = MockCityStorage()
    ) -> SearchViewModel {
        SearchViewModel(cityRepository: cityRepository, storage: storage)
    }
}
