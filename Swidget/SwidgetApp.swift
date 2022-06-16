//
//  SwidgetApp.swift
//  Swidget
//
//  Created by Jonathan Diebel on 23.04.22.
//

import SwiftUI

@main
struct SwidgetApp: App {
    @StateObject var appData: AppDataModel = AppDataModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.secondarySystemBackground
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $appData.currentTab) {
                StartPageView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Start")
                        }
                    }
                    .environmentObject(appData)
                    .tag(Tab.start)
                
                MoviesOverviewView()
                    .tabItem {
                        VStack {
                            Image(systemName: "play.tv")
                            Text("Movies")
                        }
                    }
                    .environmentObject(appData)
                    .tag(Tab.movie)
                
                SearchMovieView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .environmentObject(appData)
                    .tag(Tab.search)
            }
            .accentColor(.orange)
            .environmentObject(appData)
            // Handle opening App through link in widget
            .onOpenURL { url in
                print("url: \(url)")
                
                guard
                    url.scheme == "swidget",
                    url.host == "movie",
                    let id = Int(url.pathComponents[1])
                else {
                    print("Error openening App through widget URL.")
                    return
                }
                
                if appData.checkDeepLink(url: url, id: id) {
                    print("Deep Link successful")
                } else {
                    print("Deep Link error")
                }
            }
        }
    }
}
