//
//  SwidgetApp.swift
//  Swidget
//
//  Created by Jonathan Diebel on 23.04.22.
//

import SwiftUI

@main
struct SwidgetApp: App {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.secondarySystemBackground
        }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                StartPageView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Start")
                        }
                    }
                    .tag(0)
                
                MoviesOverviewView()
                    .tabItem {
                        VStack {
                            Image(systemName: "play.tv")
                            Text("Movies")
                        }
                    }
                    .tag(1)
                
                StartPageView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(2)
            }
            .accentColor(.orange)
        }
    }
}
