//
//  URLSessionProtocol.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 15.03.26.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
