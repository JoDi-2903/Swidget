//
//  LargeSizeView.swift
//  CategoryWidgetExtension
//
//  Created by Jonathan Diebel on 11.06.22.
//

import SwiftUI

struct LargeSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Category name")
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
            }
            .padding(.all, 5)
            
            Spacer(minLength: 4)
            
            ForEach(0 ..< 4) { i in
                let arrayElement: Int = i
                HStack(alignment: .top) {
                    Group {
                        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movies[arrayElement].backdropPath ?? "/i3IOqOFdAdjw0ebQXkIevybkkNF.jpg")"), let imageData = try? Data(contentsOf: url),
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
                    
                    VStack(alignment: .trailing) {
                        Text(entry.movies[arrayElement].title)
                            .font(.caption2)
                            .bold()
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text(entry.movies[arrayElement].releaseDate ?? "n/a")
                            .font(.body)
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text(entry.movies[arrayElement].ratingStars)
                            .font(.body)
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text(entry.movies[arrayElement].genreText)
                            .font(.body)
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text(entry.movies[arrayElement].durationTextShort)
                            .font(.body)
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                }
            }
        }
        .padding(.all, 7)
    }
}
