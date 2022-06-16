//
//  MoviesOverviewView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI

struct MoviesOverviewView: View {
    @EnvironmentObject var appData: AppDataModel
    @State var nowPlayingMovies: [Movie] = []
    @State var popularMovies: [Movie] = []
    @State var topRatedMovies: [Movie] = []
    @State var upcomingMovies: [Movie] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                MovieSliderView(title: "Popular", movies: popularMovies)
                MovieSliderView(title: "Top Rated", movies: topRatedMovies)
                MovieSliderView(title: "Upcoming", movies: upcomingMovies)
                MovieSliderView(title: "Now Playing", movies: nowPlayingMovies)
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
        }
    }
}

struct MoviesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesOverviewView()
    }
}
