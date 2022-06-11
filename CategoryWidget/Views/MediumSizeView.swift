//
//  MediumSizeView.swift
//  CategoryWidgetExtension
//
//  Created by Jonathan Diebel on 11.06.22.
//

import SwiftUI

struct MediumSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Category name")
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
            }
            .padding(.all)
            
            Spacer(minLength: 0)
            
            HStack(alignment: .bottom) {
                ForEach((0...3), id: \.self) {
                    let arrayElement: Int = $0
                    
                    Group {
                        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movies[arrayElement].posterPath ?? "/yr9A3KGQlxBh3yW0cmglsr8aMIz.jpg")"), let imageData = try? Data(contentsOf: url),
                           let uiImage = UIImage(data: imageData) {
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                            
                        } else {
                            Image("placeholder-image")
                        }
                    }
                    
                    //                    Spacer(minLength: 0)
                    //
                    //                    Text(entry.movies[0].title)
                }
            }
            .padding(.all)
        }
        .padding(.all)
    }
}
