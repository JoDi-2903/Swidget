//
//  SearchMovieView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 13.06.22.
//

import SwiftUI

struct SearchMovieView: View {
    @State var searchResultMovies: [Movie] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onTextChanged: searchMovies)
                
                List(searchResultMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id), label: {
                        Text(movie.title)
                    })
                }
            }
            .navigationTitle("Movies Overview")
            .task {
                do {
                    searchResultMovies = try await WidgetDataService.shared.getMoviesFromSearch(query: "Sonic")
                } catch {
                    print("Error loading the movies from API! \(error)")
                }
            }
        }
    }
    
    func searchMovies(for searchText: String) {
        if !searchText.isEmpty {
            Task {
                do {
                    searchResultMovies = try await WidgetDataService.shared.getMoviesFromSearch(query: searchText)
                } catch {
                    print("Error loading the movies from API! \(error)")
                }
            }
        }
    }
}

struct SearchMovieView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovieView()
    }
}
