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
    
    func checkDeepLink(url: URL, id: Int, title: String) -> Bool {
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return false
        }
        
        if title != "" && id != 0 {
            if host == Tab.start.rawValue {
                currentTab = .start
            } else if host == Tab.search.rawValue {
                currentTab = .search
            } else if host == Tab.movie.rawValue {
                currentSearchTerm = title
                currentDetailPage = id
                currentTab = .search
            } else {
                currentTab = .start
            }
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
