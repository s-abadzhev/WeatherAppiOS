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
            status = .loading
            manager.requestWhenInUseAuthorization()
            return try await waitForLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            status = .loading
            return try await waitForLocation()
        case .denied:
            status = .denied
            throw LocationError.permissionDenied
        case .restricted:
            status = .denied
            throw LocationError.permissionRestricted
        @unknown default:
            status = .failed
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
        status = .failed
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
        status = .authorized
        timeoutTask?.cancel()
        continuation?.resume(returning: location)
        continuation = nil
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        status = .failed
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
                status = .loading
                manager.requestLocation()
            }
        case .denied, .restricted:
            status = .denied
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
