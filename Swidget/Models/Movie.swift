//
//  Movie.swift
//  Swidget
//
//  Created by Jonathan Diebel on 04.06.22.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    let genres: [MovieGenre]?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    // Convert Rating to Stars
    var ratingStars: String {
        let rating = Int(voteAverage)
        if (rating > 0) {
            let ratingInStars = (Double(rating) * 0.5)
            switch ratingInStars {
            case 1:
                return "★☆☆☆☆"
            case 2:
                return "★★☆☆☆"
            case 3:
                return "★★★☆☆"
            case 4:
                return "★★★★☆"
            case 5:
                return "★★★★★"
            default:
                return "☆☆☆☆☆"
            }
        } else {
            return "n/a"
        }
    }
    
    // Extract year from release date
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    // Convert runtime of movie to hours and minutes
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
}

struct MovieGenre: Decodable {
    let name: String
}
