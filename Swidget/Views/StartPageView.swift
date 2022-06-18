//
//  ContentView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 23.04.22.
//

import SwiftUI

struct StartPageView: View {
    @EnvironmentObject var appData: AppDataModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Image("WidgetKit_TMDB_Icons")
                            .resizable()
                            .scaledToFit()
                        
                        Spacer(minLength: 5)
                        
                        Text("The app 'Swidget' was developed to present the WidgetKit and its functionalities as an example. The aim of the project is not to create an AppStore-ready application, but to present the framework in a demo. As content for the widgets and general theme movies were chosen, which are provided by the open 'The Movie Database' (TMDB) API. This app contains four pages and seven widgets, divided into three widget groups.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.all, 10)
                }
                Section {
                    Text("Add widgets to your Home Screen")
                        .font(.headline)
                        .bold()
                        .padding(.all, 5)
                    //.padding(.bottom, 10)
                    Text("1. From the Home Screen, touch and hold a widget or an empty area until the apps jiggle.")
                    Text("2. Tap the Add button Grey add button in the top left-hand corner.")
                    Text("3. Select a widget, choose from the three different widget sizes, then tap Add Widget.")
                    Text("4. Tap Done.")
                }
                Section {
                    Text("Legal notice")
                        .font(.headline)
                        .bold()
                        .padding(.all, 5)
                    Text("This product uses the TMDB API but is not endorsed or certified by TMDB.")
                    Text("Copyright by Jonathan Diebel")
                }
            }
            .navigationTitle("Welcome to Swidget")
        }
    }
}

struct StartPageView_Previews: PreviewProvider {
    static var previews: some View {
        StartPageView()
    }
}
