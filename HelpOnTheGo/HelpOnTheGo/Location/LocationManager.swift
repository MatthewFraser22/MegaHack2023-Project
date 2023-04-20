//
//  LocationManager.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    private let geocoder = CLGeocoder()
    @Published var currentLocation: CLLocation?
//    @Published var mapPins: [UserLocation] = [
//        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 48.8606, longitude: 2.3376), userId: "1"),
//        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833), userId: "2"),
//        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4769), userId: "4"),
//        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922), userId: "6"),
//        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 34.01009, longitude: -118.496948), userId: "7")
//    ]
    @Published var mapAnnotations = [MKPointAnnotation]()

    override init() {
        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    func dropPin(locationString: String) {
        geocode(locationString: locationString, completion: { location in
            if let location = location {
                let point = MKPointAnnotation(
                    __coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
                        )
                point.title = locationString

                self.mapAnnotations.append(point)
            } else {
                print("Geocoding failed")
            }
        })
    }

    func geocode(
        locationString: String,
        completion: @escaping (CLLocation?) -> Void
    ) {
        geocoder.geocodeAddressString(locationString) { (placemarks, error) in
            guard error == nil else {
                completion(nil)
                return
            }

            guard let placemark = placemarks?.first, let location = placemark.location else {
                completion(nil)
                return
            }

            completion(location)
        }
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wehn in user")
        case .authorized:
            print("authorizeed")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        DispatchQueue.main.async {
            self.currentLocation = location
        }
    }
}

