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
    @State var movieCast: [MovieCast] = []
    @State var movieCrew: [MovieCrew] = []
    @State var movieVideo: [MovieVideo] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, MovieDetailView!")
                Text("MovieID: \(movie.id)")
                Text("MovieTitle: \(movie.title)")
            }
            .navigationTitle(movie.title)
        }
        .task {
            do {
                movie = try await MovieDataService.shared.getMovieFromId(id: movieId)
                (movieCast, movieCrew, movieVideo) = try await MovieDataService.shared.getCreditsAndTrailerForMovie(movieId: movieId)
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
