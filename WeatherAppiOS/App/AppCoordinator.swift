//
//  AppCoordinator.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation

@MainActor
@Observable
final class AppCoordinator {

    var selectedCity: City?
    var isSearchPresented = false
}
