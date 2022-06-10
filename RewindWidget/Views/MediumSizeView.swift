//
//  MediumSizeView.swift
//  RewindWidgetExtension
//
//  Created by Jonathan Diebel on 10.06.22.
//

import SwiftUI

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
        .overlay(TextOverlayMediumView(entry: entry))
    }
}

struct TextOverlayMediumView: View {
    var entry: SimpleEntry
    
    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                ZStack {
                    Text("\(Calendar.current.component(.year, from: Date()).advanced(by: -Int(entry.movie.yearText)!)) years ago today")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.medium)
                        .kerning(-1)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(6)
                        .shadow(color: .orange, radius: 3, x: 2.0, y: 2.0)
                }
                .background(ContainerRelativeShape().fill(Color.black))
                .opacity(0.8)
                .cornerRadius(10.0)
                .padding(6)
                
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
