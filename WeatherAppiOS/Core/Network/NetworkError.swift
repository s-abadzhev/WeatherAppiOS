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
            return "Неверный URL"
        case .noInternetConnection:
            return "Нет подключения к интернету"
        case .timeout:
            return "Превышено время ожидания"
        case .serverError(let code):
            return "Ошибка сервера: \(code)"
        case .decodingError(let error):
            return "Ошибка парсинга: \(error.localizedDescription)"
        case .unknown(let error):
            return "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }
}
