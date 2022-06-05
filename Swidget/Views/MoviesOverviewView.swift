//
//  MoviesOverviewView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI

struct MoviesOverviewView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    List {
                        Group {
                            if nowPlayingState.movies != nil {
                                MovieSliderView(title: "Now Playing", movies: nowPlayingState.movies!)
                                
                            } else {
                                Text("Error while loading NowPlaying Slider!")
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    }
                    .navigationBarTitle("Movies Overview")
                }
            }
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
        }
    }
}

struct MoviesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesOverviewView()
    }
}
