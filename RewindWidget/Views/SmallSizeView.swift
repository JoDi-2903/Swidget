//
//  SmallSizeView.swift
//  RewindWidgetExtension
//
//  Created by Jonathan Diebel on 10.06.22.
//

import SwiftUI

struct SmallSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        ZStack {
            Group {
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movie.posterPath ?? "/yr9A3KGQlxBh3yW0cmglsr8aMIz.jpg")"), let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("placeholder-image")
                }
            }
        }
        .overlay(TextOverlaySmallView(entry: entry))
        .widgetURL(URL(string: "swidget://movie/\(entry.movie.id)"))
    }
}

struct TextOverlaySmallView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Group {
                    Text(entry.movie.yearText)
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
                .padding(.top)
                
                Spacer(minLength: 0)
            }
            .padding(.all)
            Spacer(minLength: 0)
        }
        .padding(.all)
    }
}
