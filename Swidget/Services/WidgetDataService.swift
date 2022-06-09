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
    
    // generic helper function to fetch data from given URL
    private func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        let urlString = baseAPIURL + endpoint + "?api_key=" + apiKey + "&language=en-US"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        let result = try jsonDecoder.decode(T.self, from: data)
        return result
    }
    
    func getMovieFromId(id: Int) async throws -> Movie {
        let movie: Movie = try await fetch(from: "/movie/\(id)")
        return movie
    }
}
