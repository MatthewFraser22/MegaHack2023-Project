//
//  UserLocationModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation
import CoreLocation

struct UserLocation: Identifiable {
    var coordinates: CLLocationCoordinate2D
    var userId: String
    var id: UUID { UUID() }
}
