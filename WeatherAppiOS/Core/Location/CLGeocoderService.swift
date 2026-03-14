//
//  CLGeocoderService.swift
//  WeatherAppiOS
//
//  Created by Sergey Abadzhev on 13.03.26.
//

import Foundation
import CoreLocation

final class CLGeocoderService: GeocoderService {

    private let geocoder = CLGeocoder()

    func reverseGeocode(lat: Double, lon: Double) async throws -> City {
        let location = CLLocation(latitude: lat, longitude: lon)

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            let placemark = placemarks.first

            return City(
                name: placemark?.locality ?? "Моё местоположение",
                country: placemark?.country ?? "",
                latitude: lat,
                longitude: lon
            )
        } catch {
            return City(
                name: "Моё местоположение",
                country: "",
                latitude: lat,
                longitude: lon
            )
        }
    }

    func searchCity(query: String) async throws -> [City] {
        do {
            let placemarks = try await geocoder.geocodeAddressString(query)

            return placemarks.compactMap { placemark in
                guard
                    let name = placemark.locality,
                    let location = placemark.location
                else { return nil }

                return City(
                    name: name,
                    country: placemark.country ?? "",
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
            }
        } catch {
            return []
        }
    }

    private func placeholder(lat: Double, lon: Double) -> City {
        City(name: "Моё местоположение", country: "", latitude: lat, longitude: lon)
    }
}
