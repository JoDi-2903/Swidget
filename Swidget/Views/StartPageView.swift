//
//  ContentView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 23.04.22.
//

import SwiftUI

struct StartPageView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Image("WidgetKit_TMDB_Icons")
                                    .resizable()
                                    .scaledToFit()
                        
                        Spacer(minLength: 5)
                        
                        Text("Hello, Swidget! Some descriptive text ...")
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
