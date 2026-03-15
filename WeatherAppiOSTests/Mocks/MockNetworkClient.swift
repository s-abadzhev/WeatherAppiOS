//
//  MockNetworkClient.swift
//  WeatherAppiOSTests
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation
@testable import WeatherAppiOS

final class MockNetworkClient: NetworkClient {

    var dataToReturn: Any?
    var errorToThrow: Error?
    private(set) var requestCallCount = 0
    private(set) var lastEndpoint: APIEndpoint?

    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        requestCallCount += 1
        lastEndpoint = endpoint
        if let error = errorToThrow { throw error }
        guard let data = dataToReturn as? T else {
            throw NetworkError.decodingError(
                NSError(domain: "Mock", code: -1, userInfo: [NSLocalizedDescriptionKey: "Wrong mock type"])
            )
        }
        return data
    }
}
