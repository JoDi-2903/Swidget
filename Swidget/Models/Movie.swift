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
    let budget: Int?
    let revenue: Int?
    let status: String?
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
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
    var durationTextShort: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        let runtimeHours: Int = Int(floor(Double(runtime / 60)))
        let runtimeMinutes: Int = runtime % 60
        return String("\(runtimeHours) h \(runtimeMinutes) min")
    }
}


struct MovieGenre: Decodable {
    let name: String
}

struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    
    // Only choose trailers which are hostet on YouTube
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}


// Extension for PlaceholderView of widgets
extension Movie {
    static func placeholder(_ id: Int) -> Movie {
        if (id == 1) {
            return Movie(id: id, title: "Sonic the Hedgehog 2", posterPath: "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg", backdropPath: "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg", overview: "After settling in Green Hills, Sonic is eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.", voteAverage: 7.8, voteCount: 1944, runtime: 122, releaseDate: "2022-03-30", budget: nil, revenue: nil, status: nil, genres: nil, credits: nil, videos: nil)
        } else if (id == 2) {
            return Movie(id: id, title: "Uncharted", posterPath: "/tlZpSxYuBRoVJBOpUrPdQe9FmFq.jpg", backdropPath: "/aEGiJJP91HsKVTEPy1HhmN0wRLm.jpg", overview: "A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother.", voteAverage: 7.2, voteCount: 2312, runtime: 116, releaseDate: "2022-02-10", budget: nil, revenue: nil, status: nil, genres: nil, credits: nil, videos: nil)
        } else {
            return Movie(id: id, title: "Bloodshot", posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg", backdropPath: "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg", overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", voteAverage: 7.1, voteCount: 2324, runtime: nil, releaseDate: "2020-03-05", budget: nil, revenue: nil, status: nil, genres: nil, credits: nil, videos: nil)
        }
    }
}

extension MovieCrew {
    static func placeholder(_ id: Int) -> MovieCrew {
        return MovieCrew(id: 123, job: "director", name: "Albert Loritz")
    }
}
