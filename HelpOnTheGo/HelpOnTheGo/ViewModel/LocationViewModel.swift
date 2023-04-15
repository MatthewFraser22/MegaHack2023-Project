//
//  LocationViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    static let shared = LocationViewModel()

    @Published var currentLocation: CLLocation?
    @Published var mapPins: [UserLocation] = [
        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 48.8606, longitude: 2.3376), userId: "1"),
        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833), userId: "2"),
        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4769), userId: "4"),
        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922), userId: "6"),
        UserLocation(coordinates: CLLocationCoordinate2D(latitude: 34.01009, longitude: -118.496948), userId: "7")
    ]
    
}
