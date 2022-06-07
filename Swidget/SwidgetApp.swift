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
                            Image(systemName: "tv")
                            Text("Start")
                        }
                    }
                    .tag(0)
                
                MoviesOverviewView()
                    .tabItem {
                        VStack {
                            Image(systemName: "tv")
                            Text("Movies")
                        }
                    }
                    .tag(1)
            }
            .accentColor(.orange)
        }
    }
}
