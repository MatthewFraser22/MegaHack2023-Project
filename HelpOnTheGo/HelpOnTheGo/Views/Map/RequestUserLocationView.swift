//
//  RequestUserLocationView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-18.
//

import SwiftUI

struct RequestUserLocationView: View {
    @ObservedObject private var locationManager = LocationManager.shared
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        requestLocationView
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

struct RequestUserLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestUserLocationView()
    }
}
