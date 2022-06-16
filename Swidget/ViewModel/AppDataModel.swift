//
//  AppDataModel.swift
//  Swidget
//
//  Created by Jonathan Diebel on 15.06.22.
//

import SwiftUI

class AppDataModel: ObservableObject {
    
    @Published var currentTab: Tab = .start
    @Published var currentDetailPage: Int?
    @Published var currentSearchTerm: String?
    
    func checkDeepLink(url: URL, id: Int) -> Bool {
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return false
        }
        
        if host == Tab.start.rawValue {
            currentTab = .start
        } else if host == Tab.movie.rawValue {
            return resolveMovieDetailLink(host: host, id: id)
        } else if host == Tab.search.rawValue {
            currentTab = .search
        } else {
            currentTab = .start
        }
        
        return true
    }
    
    func resolveMovieDetailLink(host: String, id: Int) -> Bool {
        print("ID from Link: \(id)")
        if id != 0 {
            Task {
                do {
                    let linkMovie: Movie = try await MovieDataService.shared.getMovieFromId(id: id)
                    currentSearchTerm = linkMovie.title
                } catch {
                    print("Invalid movie id through link.")
                }
            }
            currentTab = .search
            currentDetailPage = id
            return true
        } else {
            return false
        }
    }
}

enum Tab: String {
    case start = "start"
    case movie = "movie"
    case search = "search"
}
