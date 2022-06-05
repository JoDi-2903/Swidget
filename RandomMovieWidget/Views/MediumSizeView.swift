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
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            HStack {
                Text(String(movieId))
                //Text(self.movieDetailState.movie!.title)
//                if self.imageLoader.image != nil {
//                    Image(uiImage: self.imageLoader.image!)
//                        .resizable()
//                }
//                Text(movie.yearText)
//                    .italic()
//                Text(movie.title)
            }
        }
        .onAppear {
            //self.movieDetailState.loadMovie(id: self.movieId)
            //self.imageLoader.loadImage(with: self.movieDetailState.movie!.backdropURL)
        }
    }
}
