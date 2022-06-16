//
//  SearchMovieView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 13.06.22.
//

import SwiftUI

struct SearchMovieView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var appData: AppDataModel
    @State var searchResultMovies: [Movie] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onTextChanged: searchMovies)
                
                List(searchResultMovies) { movie in
                    NavigationLink(tag: movie.id, selection: $appData.currentDetailPage) { MovieDetailView(movieId: movie.id) } label: {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text(movie.yearText)
                                .font(.subheadline)
                                .italic()
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
        .onAppear(perform: {
            if appData.currentSearchTerm != nil {
                searchMovies(for: appData.currentSearchTerm!)
                appData.currentSearchTerm = nil
            }
        })
        .onDisappear(perform: {
            if appData.currentSearchTerm != nil {
                searchMovies(for: appData.currentSearchTerm!)
                appData.currentSearchTerm = nil
            }
        })
        .task {
            // Search movie to allow opening DetailView via NavigationLink
            if appData.currentSearchTerm != nil {
                searchMovies(for: appData.currentSearchTerm!)
                appData.currentSearchTerm = nil
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background || newPhase == .inactive {
                searchResultMovies.removeAll()
                appData.currentTab = .start
            }
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
