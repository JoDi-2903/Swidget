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
                
                let id = Int(url.pathComponents[1])
                let title = String(url.pathComponents[2])
                
                print("ID from Link: \(id ?? 675353)")
                print("Title from Link: \(title)")
                
                if appData.checkDeepLink(url: url, id: id!, title: title) {
                    print("Deep Link valid")
                } else {
                    print("Deep Link error")
                }
            }
        }
    }
}
