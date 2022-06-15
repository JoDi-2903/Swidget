//
//  MovieDetailView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 13.06.22.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @State var movie: Movie = .placeholder(1)
    @State var movieCast: [MovieCast] = []
    @State var movieCrew: [MovieCrew] = []
    @State var movieVideo: [MovieVideo] = []
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    // BackgroundImage
                    let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath ?? "")")
                    Group {
                        if let url = backdropURL, let imageData = try? Data(contentsOf: url),
                           let uiImage = UIImage(data: imageData) {
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image("placeholder-image")
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    // Details
                    HStack {
                        Text(movie.yearText)
                        Text("• \(movie.genreText)")
                        Text("• \(movie.durationTextShort)")
                    }
                    
                    //Overview
                    VStack(alignment: .leading) {
                        Text("Overview: ")
                            .bold()
                        Text(movie.overview)
                    }
                    
                    // Rating
                    HStack {
                        Text("Rating: ")
                            .bold()
                        if movie.voteAverage != 0 {
                            Text(movie.ratingStars)
                                .foregroundColor(.yellow)
                            Text(" (\(movie.voteCount) votes)")
                                .italic()
                        } else {
                            Text("No rating available.")
                        }
                    }
                    
                    // More Information
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Status: ").bold()
                            Text("Release: ").bold()
                            Text("Budget: ").bold()
                            Text("Revenue: ").bold()
                        }
                        
                        Spacer(minLength: 5)
                        
                        VStack(alignment: .trailing) {
                            Text(movie.status ?? "Not available.")
                            Text(movie.releaseDate ?? "No date available.")
                            Text("\(movie.budget ?? 0) $")
                            Text("\(movie.revenue ?? 0) $")
                        }
                    }
                    
                    Divider()
                    
                    // Cast and Crew
                    MovieCreditsView(movieCast: movieCast, movieCrew: movieCrew)
                    
                    Divider()
                    
                    // Trailer
                    if movieVideo.filter({ $0.site.lowercased() == "youtube" }).count > 0 {
                        let video = movieVideo.filter({ $0.site.lowercased() == "youtube" })
                        Link("Watch trailer", destination: URL(string: "https://youtube.com/watch?v=\(video[0].key)")!)
                            .foregroundColor(.orange)
                    }
                }
            }
            .navigationTitle(movie.title)
        }
        .task {
            do {
                movie = try await MovieDataService.shared.getMovieFromId(id: movieId)
                (movieCast, movieCrew, movieVideo) = try await MovieDataService.shared.getCreditsAndTrailerForMovie(movieId: movieId)
            } catch {
                print("Error loading the movie from API! \(error)")
            }
        }
    }
}


struct MovieCreditsView: View {
    let movieCast: [MovieCast]
    let movieCrew: [MovieCrew]
    
    var body: some View {
        // Cast
        HStack {
            VStack(alignment: .leading) {
                if (movieCast.count > 0) {
                    Text("Cast: ").bold()
                    ForEach(movieCast.prefix(9)) { cast in
                        Text(cast.name)
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                }
            }
            
            Spacer(minLength: 5)
            
            VStack(alignment: .leading) {
                if (movieCast.count > 0) {
                    Text("")
                    ForEach(movieCast.prefix(9)) { cast in
                        Text("as \(cast.character)")
                            .foregroundColor(.orange)
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                }
            }
        }
        
        // Crew
        if (movieCrew.count > 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Producer(s): ").bold()
                    ForEach(movieCrew.filter({ $0.job.lowercased() == "producer" }).sorted(by: { $0.name < $1.name }).prefix(4)) { crew in
                        Text(crew.name)
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                }
                
                Spacer(minLength: 7)
                
                VStack(alignment: .leading) {
                    Text("Director(s): ").bold()
                    ForEach(movieCrew.filter({ $0.job.lowercased() == "director" }).sorted(by: { $0.name < $1.name }).prefix(1)) { crew in
                        Text(crew.name)
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text("Screenwriter(s): ").bold()
                    ForEach(movieCrew.filter({ $0.job.lowercased() == "story" }).sorted(by: { $0.name < $1.name }).prefix(1)) { crew in
                        Text(crew.name)
                            .lineLimit(1)
                    }
                }
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: 361743)
    }
}
