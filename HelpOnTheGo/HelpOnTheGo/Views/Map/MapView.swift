//
//  MapView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var locationViewModel = LocationViewModel.shared
    @ObservedObject private var locationManager = LocationManager.shared
    @Environment(\.presentationMode) var presentationMode
    @State var selectedUser: UserLocation? = nil

    var region: Binding<MKCoordinateRegion>? {
        guard let location = locationManager.currentLocation else {
            return MKCoordinateRegion.goldenGateBridge().getBinding()
        }

        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)

        return region.getBinding()
    }

    var body: some View {
        if locationManager.currentLocation == nil {
            requestLocationView
        } else {
            if let region = region {
                ZStack {
                    mapView(region: region)
                }
            }
        }
    }

    private func mapView(region: Binding<MKCoordinateRegion>) -> some View {
        ZStack {
            Map(
                coordinateRegion: region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: locationViewModel.mapPins) { userLocation in
                    MapAnnotation(coordinate: userLocation.coordinates) {

                        LocationMapAnnotationView(isHelper: true)
                            .shadow(radius: 10)
                            .onTapGesture {
                                selectedUser = userLocation
                            }
                    }
                }
                .edgesIgnoringSafeArea(.top)

            if let user = selectedUser {
                GeometryReader { geometry in
                    LocationPreviewView(userLocation: $selectedUser, user: User(name: "matt", email: "TweetImage", date: "1/2/2022", _id: "123"))
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

    private var requestLocationView: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.top)

            VStack {
                Spacer()

                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)

                Text("Would you like to see helpers or people in need nearby")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Start sharing your location")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.medium)

                Spacer()

                VStack {
                    Button {
                        locationManager.requestUserLocation()
                    } label: {
                        Text("Allow Location")
                            .foregroundColor(.backgroundColor)
                            .padding()
                            .font(.headline)
                    }
                    .background(Color.white)
                    .clipShape(Capsule())
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Maybe Later")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                Spacer()

            }.padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
