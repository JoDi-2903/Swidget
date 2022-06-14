//
//  MovieDetailView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 13.06.22.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @State var movie: Movie = .placeholder(1)
    
    var body: some View {
        VStack {
            Text("Hello, MovieDetailView!")
            Text("MovieID: \(movie.id)")
            Text("MovieTitle: \(movie.title)")
        }
        .task {
            do {
                movie = try await MovieDataService.shared.getMovieFromId(id: movieId)
            } catch {
                print("Error loading the movie from API! \(error)")
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: 361743)
    }
}
