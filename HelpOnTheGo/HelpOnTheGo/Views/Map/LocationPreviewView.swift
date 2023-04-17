//
//  LocationPreviewView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import CoreLocation

struct LocationPreviewView: View {
    @Binding var userLocation: UserLocation?
    let user: User?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                titleSection
            }

            VStack(spacing: 8) {
                cancelMoreButton
                messageButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user!.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("HELPER")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cancelMoreButton: some View {
        Button {
            userLocation = nil
        } label: {
            Text("Cancel")
                .font(.headline)
                .frame(width: 125, height: 35)
        }.buttonStyle(.borderedProminent)
    }
    
    private var messageButton: some View {
        Button {
            // go to message
        } label: {
            Text("Message")
                .font(.headline)
                .frame(width: 125, height: 35)
        }.buttonStyle(.bordered)
    }
}

//struct LocationPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.green
//            LocationPreviewView(
//                userLocation: .constant(UserLocation(coordinates: CLLocationCoordinate2D(latitude: 48.8606, longitude: 2.3376), user: User(name: "matt", image: "TweetImage", userstate: "helper"))
//        }
//    }
//}
