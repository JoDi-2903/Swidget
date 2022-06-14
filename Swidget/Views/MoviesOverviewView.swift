//
//  MoviesOverviewView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI

struct MoviesOverviewView: View {
    
    @State var nowPlayingMovies: [Movie] = []
    @State var popularMovies: [Movie] = []
    @State var topRatedMovies: [Movie] = []
    @State var upcomingMovies: [Movie] = []
    @State var selectedMovie: Movie?
    
    var body: some View {
        NavigationView {
            List(nowPlayingMovies) { movie in
                NavigationLink(destination: MovieDetailView(movieId: movie.id), label: {
                    Text(movie.title)
                })
            }
            .navigationTitle("Movies Overview")
            .task {
                do {
                    nowPlayingMovies = try await MovieDataService.shared.getMoviesFromCategory(category: "now_playing", language: "en-US")
                    popularMovies = try await MovieDataService.shared.getMoviesFromCategory(category: "popular", language: "en-US")
                    topRatedMovies = try await MovieDataService.shared.getMoviesFromCategory(category: "top_rated", language: "en-US")
                    upcomingMovies = try await MovieDataService.shared.getMoviesFromCategory(category: "upcoming", language: "en-US")
                } catch {
                    print("Error loading the movies from API! \(error)")
                }
            }
//            .sheet(item: $selectedMovie) { movie in
//                GroupBox {
//                    VStack(alignment: .leading) {
//                        Text(movie.title)
//                            .font(.headline)
//
//                        Text(movie.overview)
//                            .font(.body)
//                    }
//                } label: {
//                    Label("Movie details", systemImage: "person")
//                }
//                .padding()
//            }
        }
        
        //        NavigationView {
        //            VStack {
        //                HStack {
        //                    List {
        //                        Group {
        //                            if nowPlayingState.movies != nil {
        //                                MovieSliderView(title: "Now Playing", movies: nowPlayingState.movies!)
        //
        //                            } else {
        //                                Text("Error while loading NowPlaying Slider!")
        //                            }
        //                        }
        //                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
        //                    }
        //                    .navigationBarTitle("Movies Overview")
        //                }
        //            }
        //        }
        //        .onAppear {
        //            self.nowPlayingState.loadMovies(with: .nowPlaying)
        //        }
    }
}

struct MoviesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesOverviewView()
    }
}
