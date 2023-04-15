//
//  MKCoordinateRegion+Extensions.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import MapKit
import SwiftUI

extension MKCoordinateRegion {
    static func goldenGateBridge() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.81952709, longitude: -122.478546020), latitudinalMeters: 5000, longitudinalMeters: 5000)
    }

    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
