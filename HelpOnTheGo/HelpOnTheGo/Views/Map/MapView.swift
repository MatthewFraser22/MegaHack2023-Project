//
//  MapView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @State var selectedUser: UserLocation? = nil

//    var region: Binding<MKCoordinateRegion>? {
//        guard let location = locationManager.currentLocation else {
//            return MKCoordinateRegion.goldenGateBridge().getBinding()
//        }
//
//        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//
//        return region.getBinding()
//    }

    var body: some View {
        if locationManager.currentLocation == nil {
            RequestUserLocationView()
        } else {
//            if let region = region {
            ZStack {
                // mapView(region: region)
                mapView
            }
//            }
        }
    }

//    private func mapView(region: Binding<MKCoordinateRegion>) -> some View {
    var mapView: some View {
        ZStack {
//            Map(
//                coordinateRegion: region,
//                interactionModes: .all,
//                showsUserLocation: true,
//                userTrackingMode: .constant(.follow),
//                annotationItems: locationManager.mapPins
//            ) { userLocation in
//                    MapAnnotation(coordinate: userLocation.coordinates) {
//
//                        LocationMapAnnotationView(isHelper: true)
//                            .shadow(radius: 10)
//                            .onTapGesture {
//                                selectedUser = userLocation
//                            }
//                    }
//                }
//                .edgesIgnoringSafeArea(.top)
            MapKitUIViewRepresentable(annotations: $locationManager.mapAnnotations)
                .edgesIgnoringSafeArea(.all)
            Text("Annotation: \(locationManager.mapAnnotations.first?.coordinate.latitude ?? MKPointAnnotation().coordinate.latitude)")

            if let user = selectedUser {
                GeometryReader { geometry in
                    LocationPreviewView(userLocation: $selectedUser, user: User(name: "matt", email: "TweetImage", _id: "123", location: nil, date: nil))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                        .background(Color.clear)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - geometry.size.height * 0.25)
                }
                .onTapGesture {
                    selectedUser = nil
                }
            }
        }
    }

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
