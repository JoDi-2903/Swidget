//
//  MediumSizeView.swift
//  RandomMovieWidgetExtension
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI
import WidgetKit

struct MediumSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movie.backdropPath ?? "/i3IOqOFdAdjw0ebQXkIevybkkNF.jpg")")
        ZStack {
            Group {
                if let url = backdropURL, let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("placeholder-image")
                }
            }
        }
        .overlay(TextOverlayView(entry: entry))
    }
}

struct TextOverlayView: View {
    var entry: SimpleEntry
    
    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                Spacer(minLength: 0)
                Text(entry.movie.yearText)
                    .font(.body)
                    .fontWeight(.medium)
                    .italic()
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(entry.movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .shadow(color: .black, radius: 3, x: 2.0, y: 2.0)
            }
            .padding(.all)
            Spacer(minLength: 0)
        }
        .padding(.all)
    }
}
