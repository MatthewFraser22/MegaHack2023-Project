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
    var body: some View {
        ZStack {

            tabBarView
        }
    }

    // MARK: Views

    private var tabBarView: some View {
        TabView {
            PostView()
                .tabItem {
                    Image(systemName: "house")
                }
                .toolbar(.hidden)
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
                .toolbar(.hidden)
            MessageView()
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
