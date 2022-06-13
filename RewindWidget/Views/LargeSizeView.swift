//
//  LargeSizeView.swift
//  RewindWidgetExtension
//
//  Created by Jonathan Diebel on 10.06.22.
//

import SwiftUI

struct LargeSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movie.backdropPath ?? "/i3IOqOFdAdjw0ebQXkIevybkkNF.jpg")")
        ZStack {
            VStack {
                Group {
                    if let url = backdropURL, let imageData = try? Data(contentsOf: url),
                       let uiImage = UIImage(data: imageData) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .brightness(-0.15)
                            .blur(radius: 1)
                    } else {
                        Image("placeholder-image")
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .overlay(TextOverlayLargeView(entry: entry))
        .widgetURL(URL(string: "swidget://movie/\(entry.movie.id)"))
    }
}

struct TextOverlayLargeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Group {
                    if let url = URL(string: "https://image.tmdb.org/t/p/w500\(entry.movie.posterPath ?? "/yr9A3KGQlxBh3yW0cmglsr8aMIz.jpg")"), let imageData = try? Data(contentsOf: url),
                       let uiImage = UIImage(data: imageData) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 129, height: 200)
                            .shadow(radius: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white, lineWidth: 3)
                            )
                        
                    } else {
                        Image("placeholder-image")
                    }
                }
                
                Spacer(minLength: 0)
                
                DetailsView(entry: entry)
            }
            .padding(.all)
            
            Spacer(minLength: 0)
            
            HStack(alignment: .bottom) {
                OverviewAndCastView(entry: entry)
            }
            .padding(.all)
        }
    }
}

struct DetailsView: View {
    var entry: SimpleEntry
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Group {
                Text("\(Calendar.current.component(.year, from: Date()).advanced(by: -Int(entry.movie.yearText)!)) years ago today")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.medium)
                    .kerning(-1)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                Text(entry.movie.title)
                    .font(.title2)
                    .bold()
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .allowsTightening(true)
                    .shadow(color: .black, radius: 6, x: 4, y: 4)
                
                Spacer(minLength: 17)
            }
            
            Group {
                HStack {
                    Text("Release: ").bold()
                    Text(entry.movie.releaseDate!)
                }
                .foregroundColor(.white)
                .font(.system(size: 16))
                .lineLimit(1)
                .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("Rating: ").bold()
                    Text(entry.movie.ratingStars)
                }
                .foregroundColor(.white)
                .font(.system(size: 16))
                .lineLimit(1)
                .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("Genres: ").bold()
                    Text(entry.movie.genreText)
                }
                .foregroundColor(.white)
                .font(.system(size: 16))
                .lineLimit(1)
                .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("Runtime: ").bold()
                    Text(entry.movie.durationTextShort)
                }
                .foregroundColor(.white)
                .font(.system(size: 16))
                .lineLimit(1)
                .allowsTightening(true)
                .shadow(radius: 5)
            }
        }
    }
}

struct OverviewAndCastView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Overview: ")
                .bold()
                .font(.system(size: 16))
            Text(entry.movie.overview)
                .font(.system(size: 16))
                //.lineLimit(6)
                //.allowsTightening(true)
            
            Spacer(minLength: 0)
            
            let directors = entry.movieCrew.filter({ $0.job.lowercased() == "director" })
            if entry.movieCrew.first(where: { $0.job.lowercased() == "director" }) != nil && entry.movieCrew.count > 0 {
                HStack {
                    if (directors.count > 1) {
                        Text("Directors: ").bold()
                        Text("\(directors[0].name), \(directors[1].name)")
                    } else {
                        Text("Director: ").bold()
                        Text("\(directors[0].name)")
                    }
                }
                .font(.system(size: 16))
                .lineLimit(1)
            }
            
            Spacer(minLength: 0)
            
            let producers = entry.movieCrew.filter({ $0.job.lowercased() == "producer" })
            if entry.movieCrew.first(where: { $0.job.lowercased() == "producer" }) != nil && entry.movieCrew.count > 0 {
                HStack {
                    if (producers.count > 1) {
                        Text("Producers: ").bold()
                        Text("\(producers[0].name), \(producers[1].name)")
                    } else {
                        Text("Producer: ").bold()
                        Text("\(producers[0].name)")
                    }
                }
                .font(.system(size: 16))
                .lineLimit(1)
            }
        }
    }
}
