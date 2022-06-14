//
//  WidgetDataService.swift
//  Swidget
//
//  Created by Jonathan Diebel on 09.06.22.
//

import Foundation

final class MovieDataService {
    static let shared = MovieDataService()
    
    private let apiKey = "5221e1317dbf91f51363a72bc6c98904"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let jsonDecoder = Utils.jsonDecoder
    
    // generic helper function to fetch data from given URL
    private func fetch<T: Decodable>(endpoint: String, parameters: String) async throws -> T {
        let urlString = baseAPIURL + endpoint + "?api_key=" + apiKey + parameters
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else {
            throw URLError(.badServerResponse)
        }
        
        let result = try jsonDecoder.decode(T.self, from: data)
        return result
    }
    
    func getMovieFromId(id: Int) async throws -> Movie {
        let movie: Movie = try await fetch(endpoint: "/movie/\(id)", parameters: "&language=en-US")
        return movie
    }
    
    func getRandomMovie() async throws -> Movie {
        let randomPageNumber = Int.random(in: 1...200)
        
        // There are currently 14974 results and 749 pages for the selected parameters
        let randomMoviesResponse: MovieResponse = try await fetch(endpoint: "/discover/movie", parameters: "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(randomPageNumber)&vote_count.gte=100&vote_average.gte=5")
        
        let randomMovie: Movie = randomMoviesResponse.results.randomElement()!
        return randomMovie
    }
    
    func getReleasedOnThisDay(yearsAgo: Int) async throws -> Movie {
        // Calculate past date
        let getSearchDate: Date = Calendar.current.date(byAdding: .year, value: -yearsAgo, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let getSearchDateString = dateFormatter.string(from: getSearchDate)
        
        // Get movie from discover
        let movieResponse: MovieResponse = try await fetch(endpoint: "/discover/movie", parameters: "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=\(getSearchDateString)&primary_release_date.lte=\(getSearchDateString)")
        let singleMovie: Movie = movieResponse.results[0]
        
        return singleMovie
    }
    
    func getMoviesFromCategory(category: String, language: String?) async throws -> [Movie] {
        if (category == "top_rated" || category == "popular" || category == "upcoming" || category == "now_playing") {
            let movieResponse: MovieResponse = try await fetch(endpoint: "/movie/\(category)", parameters: "&language=\(language?.replacingOccurrences(of: "_", with: "-") ?? "en-US")&page=1")
            let returnMovies: [Movie] = movieResponse.results
            return returnMovies
        } else {
            return [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)]
        }
    }
    
    func getCreditsAndTrailerForMovie(movieId: Int) async throws -> ([MovieCast], [MovieCrew], [MovieVideo]) {
        // Load credits and trailers for movie
        let movieCredit: MovieCredit = try await fetch(endpoint: "/movie/\(movieId)/credits", parameters: "&language=en-US")
        let movieCast: [MovieCast] = movieCredit.cast
        let movieCrew: [MovieCrew] = movieCredit.crew
        
        let movieVideoResponse: MovieVideoResponse = try await fetch(endpoint: "/movie/\(movieId)/videos", parameters: "&language=en-US")
        let movieVideos: [MovieVideo] = movieVideoResponse.results
        
        return (movieCast, movieCrew, movieVideos)
    }
    
    func getMoviesFromSearch(query: String) async throws -> [Movie] {
        let searchResponse: MovieResponse = try await fetch(endpoint: "/search/movie", parameters: "&language=en-US&query=\(query)&page=1&include_adult=false")
        let returnMovies: [Movie] = searchResponse.results
        return returnMovies
    }
}
