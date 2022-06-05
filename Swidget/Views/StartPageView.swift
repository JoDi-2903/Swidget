//
//  ContentView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 23.04.22.
//

import SwiftUI

struct StartPageView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Hello, Swidget!")
                    .padding()
            }
        }
    }
}

struct StartPageView_Previews: PreviewProvider {
    static var previews: some View {
        StartPageView()
    }
}
