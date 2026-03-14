//
//  NetworkError.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noInternetConnection
    case timeout
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return L10n.Error.invalidURL
        case .noInternetConnection:
            return L10n.Error.noInternet
        case .timeout:
            return L10n.Error.timeout
        case .serverError(let code):
            return L10n.Error.server(code)
        case .decodingError:
            return L10n.Error.decoding
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
