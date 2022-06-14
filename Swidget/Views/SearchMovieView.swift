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
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text(movie.yearText)
                                .font(.subheadline)
                                .italic()
                                .foregroundColor(.orange)
                        }
                    })
                }
            }
            .navigationTitle("Search")
        }
    }
    
    func searchMovies(for searchText: String) {
        if !searchText.isEmpty {
            Task {
                do {
                    searchResultMovies = try await MovieDataService.shared.getMoviesFromSearch(query: searchText.replacingOccurrences(of: " ", with: "%20"))
                } catch {
                    print("Error loading the movies from API! \(error)")
                }
            }
        } else {
            // remove search result when a user clear keyword.
            searchResultMovies.removeAll()
        }
    }
}

struct SearchMovieView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovieView()
    }
}
