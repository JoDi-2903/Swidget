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
    let title: String
    let year: String
    let backdropURL: URL?
    
    var body: some View {
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
        .overlay(TextOverlayView(entry: entry, title: title, year: year))
    }
}

struct TextOverlayView: View {
    var entry: SimpleEntry
    let title: String
    let year: String
    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                Spacer(minLength: 0)
                Text(year)
                    .font(.body)
                    .fontWeight(.medium)
                    .italic()
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(title)
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
