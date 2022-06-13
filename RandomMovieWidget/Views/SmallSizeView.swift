//
//  SmallSizeView.swift
//  RandomMovieWidgetExtension
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI
import WidgetKit

struct SmallSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
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
        .widgetURL(URL(string: "swidget://movie/\(entry.movie.id)"))
    }
}
