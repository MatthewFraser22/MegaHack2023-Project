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
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            MessageView()
                .tabItem {
                    Image(systemName: "message")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
