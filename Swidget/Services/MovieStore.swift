//
//  MovieStore.swift
//  Swidget
//
//  Created by Jonathan Diebel on 04.06.22.
//

import Foundation

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {} // Instance can only be initialised once in a runtime
    
    private let apiKey = "5221e1317dbf91f51363a72bc6c98904"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
}
