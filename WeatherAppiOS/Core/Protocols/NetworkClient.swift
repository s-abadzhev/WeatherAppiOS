//
//  NetworkClient.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

protocol NetworkClient: Sendable {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}
