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
                    .shadow(radius: 5)
            }
            
            Spacer(minLength: 1)
            
            Group {
                HStack {
                    Text("Release: ").bold()
                    Text(entry.movie.yearText)
                }
                .foregroundColor(.white)
                .font(.body)
                .lineLimit(1)
                .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("Rating: ").bold()
                    Text(entry.movie.ratingStars)
                }
                .foregroundColor(.white)
                .font(.body)
                .lineLimit(1)
                .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("Genres: ").bold()
                    Text(entry.movie.genreText)
                }
                .foregroundColor(.white)
                .font(.body)
                .lineLimit(1)
                .shadow(radius: 5)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text("Runtime: ").bold()
                    Text(entry.movie.durationTextShort)
                }
                .foregroundColor(.white)
                .font(.body)
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
            Text("Overview: ").bold()
            Text(entry.movie.overview)
                .font(.body)
                .lineLimit(5)
                .allowsTightening(true)
            
            Spacer(minLength: 0)
            
            if entry.movie.directors != nil && entry.movie.directors!.count > 0 {
                HStack {
                    Text("Director(s): ").bold()
                    ForEach(entry.movie.directors!.prefix(2)) { crew in
                        Text(crew.name)
                    }
                }
                .font(.body)
                .lineLimit(1)
            }
            
            Spacer(minLength: 0)
            
            if entry.movie.producers != nil && entry.movie.producers!.count > 0 {
                HStack {
                    Text("Producer(s): ").bold()
                    ForEach(entry.movie.producers!.prefix(2)) { crew in
                        Text(crew.name)
                    }
                }
                .font(.body)
                .lineLimit(1)
            }
        }
    }
}
