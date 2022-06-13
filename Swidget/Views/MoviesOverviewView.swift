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
    
    //    @ObservedObject private var nowPlayingState = MovieListState()
    //    @ObservedObject private var upcomingState = MovieListState()
    //    @ObservedObject private var topRatedState = MovieListState()
    //    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            List(nowPlayingMovies) { movie in
                Button {
                    selectedMovie = movie
                } label: {
                    Text(movie.title)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Movies Overview")
            .task {
                do {
                    nowPlayingMovies = try await WidgetDataService.shared.getMoviesFromCategory(category: "now_playing", language: "en-US")
                    popularMovies = try await WidgetDataService.shared.getMoviesFromCategory(category: "popular", language: "en-US")
                    topRatedMovies = try await WidgetDataService.shared.getMoviesFromCategory(category: "top_rated", language: "en-US")
                    upcomingMovies = try await WidgetDataService.shared.getMoviesFromCategory(category: "upcoming", language: "en-US")
                } catch {
                    print("Error loading the movies from API! \(error)")
                }
            }
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
