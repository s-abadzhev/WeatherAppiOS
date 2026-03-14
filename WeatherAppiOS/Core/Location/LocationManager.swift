//
//  LocationManager.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation
import CoreLocation

@Observable
final class LocationManager: NSObject {

    var status: LocationStatus = .idle

    private let manager: CLLocationManager
    private var continuation: CheckedContinuation<CLLocation, Error>?
    private var timeoutTask: Task<Void, Never>?

    override init() {
        self.manager = CLLocationManager()
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func requestLocation() async throws -> CLLocation {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            return try await waitForLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            status = .loading
            return try await waitForLocation()
        case .denied:
            throw LocationError.permissionDenied
        case .restricted:
            throw LocationError.permissionRestricted
        @unknown default:
            throw LocationError.locationUnavailable
        }
    }

    // MARK: - Private

    private func waitForLocation() async throws -> CLLocation {
        cancelPendingRequest()

        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else { return }
            self.continuation = continuation
            self.manager.requestLocation()
            self.startTimeout()
        }
    }

    private func startTimeout(seconds: Double = 10) {
        timeoutTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            guard !Task.isCancelled else { return }
            self?.handleTimeout()
        }
    }

    private func handleTimeout() {
        manager.stopUpdatingLocation()
        continuation?.resume(throwing: LocationError.timeout)
        continuation = nil
    }

    private func cancelPendingRequest() {
        timeoutTask?.cancel()
        timeoutTask = nil
        continuation?.resume(throwing: CancellationError())
        continuation = nil
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        timeoutTask?.cancel()
        continuation?.resume(returning: location)
        continuation = nil
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        timeoutTask?.cancel()
        let locationError: LocationError = (error as? CLError)?.code == .denied
            ? .permissionDenied
            : .locationUnavailable
        continuation?.resume(throwing: locationError)
        continuation = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if continuation != nil {
                manager.requestLocation()
            }
        case .denied, .restricted:
            let error: LocationError = manager.authorizationStatus == .denied
                ? .permissionDenied
                : .permissionRestricted
            continuation?.resume(throwing: error)
            continuation = nil
        default:
            break
        }
    }
}
