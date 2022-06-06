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
        VStack(alignment: .leading) {
            Text(year)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .lineLimit(1)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
                .allowsTightening(true)
                .shadow(color: .black, radius: 1, x: 1.0, y: 1.0)
        }
    }
}
