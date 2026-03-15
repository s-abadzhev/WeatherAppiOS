//
//  NetworkClientTests.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
import Testing
@testable import WeatherAppiOS

@MainActor
struct NetworkClientTests {

    @Test("Успешный запрос декодирует данные")
    func request_success_decodesResponse() async throws {
        let session = MockURLSession(
            data: CurrentWeatherResponseDTO.mockJSON,
            response: HTTPURLResponse(
                url: URL(string: "https://api.open-meteo.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        let sut = URLSessionNetworkClient(session: session)

        let result: CurrentWeatherResponseDTO = try await sut.request(.currentWeather(lat: 55.75, lon: 37.61))
        #expect(result.current.weatherCode == 0)
    }

    @Test("Ответ 404 бросает serverError")
    func request_404_throwsServerError() async {
        let session = MockURLSession(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://api.open-meteo.com")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        let sut = URLSessionNetworkClient(session: session)

        await #expect(throws: NetworkError.serverError(statusCode: 404)) {
            let _: CurrentWeatherResponseDTO = try await sut.request(.currentWeather(lat: 55.75, lon: 37.61))
        }
    }

    @Test("Нет интернета бросает noInternetConnection")
    func request_noInternet_throwsNoInternetConnection() async {
        let session = MockURLSession(error: URLError(.notConnectedToInternet))
        let sut = URLSessionNetworkClient(session: session)

        await #expect(throws: NetworkError.noInternetConnection) {
            let _: CurrentWeatherResponseDTO = try await sut.request(.currentWeather(lat: 55.75, lon: 37.61))
        }
    }
}

// MARK: - MockURLSession

final class MockURLSession: URLSessionProtocol {

    private let mockData: Data?
    private let mockResponse: URLResponse?
    private let mockError: Error?

    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError { throw error }
        return (mockData ?? Data(), mockResponse ?? URLResponse())
    }
}
