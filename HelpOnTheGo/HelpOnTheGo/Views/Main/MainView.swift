//
//  MainView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

fileprivate enum TabState: Int {
    case home
}

struct MainView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var locationManager: LocationManager

    var messages: [Message] = [
        Message(sender: "Matt", body: "Hey!")
    ]
    var body: some View {
        ZStack {
            tabBarView
        }
    }

    // MARK: Views

    private var tabBarView: some View {
        TabView {
            PostView()
                .environmentObject(authVM)
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "house")
                }
                .toolbar(.hidden)
            MapView()
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "map")
                }
                .toolbar(.hidden)
            MessageListView(messages: messages)
                .tabItem {
                    Image(systemName: "message")
                }
                .toolbar(.hidden)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .toolbar(.hidden)
        }.tint(Color.backgroundColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
