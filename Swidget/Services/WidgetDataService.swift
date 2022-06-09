//
//  WidgetDataService.swift
//  Swidget
//
//  Created by Jonathan Diebel on 09.06.22.
//

import Foundation

final class WidgetDataService {
    static let shared = WidgetDataService()
    
    private let apiKey = "5221e1317dbf91f51363a72bc6c98904"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let jsonDecoder = Utils.jsonDecoder
    
    func getMovieFromId(id: Int) async throws -> Movie {
        let movie: Movie = .placeholder(42)
        return movie
    }
}
