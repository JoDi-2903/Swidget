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
            let group = DispatchGroup()
            
            group.enter()
            DispatchQueue.global(qos: .default).async {
                Task {
                    do {
                        let linkMovie: Movie = try await MovieDataService.shared.getMovieFromId(id: id)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.currentSearchTerm = linkMovie.title
                        }
                    } catch {
                        print("Invalid movie id through link.")
                    }
                }
                
                    group.leave()
                }
            group.wait()
            
            currentDetailPage = id
            currentTab = .search
            
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
