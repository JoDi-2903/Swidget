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
                Text(entry.categoryName.replacingOccurrences(of: "_", with: " ").capitalizingFirstLetter())
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
            }
            .padding(.all, 5)
            
            Spacer(minLength: 4)
            
            HStack(alignment: .bottom) {
                ForEach((0...3), id: \.self) {
                    let arrayElement: Int = $0
                    
                    Link(destination: URL(string: "swidget://movie/\(entry.movies[arrayElement].id)")!) {
                        Group {
                            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movies[arrayElement].posterPath ?? "/yr9A3KGQlxBh3yW0cmglsr8aMIz.jpg")"), let imageData = try? Data(contentsOf: url),
                               let uiImage = UIImage(data: imageData) {
                                
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 7)
                                    .cornerRadius(8)
                                
                            } else {
                                Image("placeholder-image")
                            }
                        }
                    }
                }
            }
        }
        .padding(.all, 7)
    }
}
