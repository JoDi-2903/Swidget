//
//  MovieSliderView.swift
//  Swidget
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI

struct MovieSliderView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .heavy))
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(7)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(movies.prefix(19)) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id), label: {
                        VStack(spacing: 8) {
                            Group {
                                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"), let imageData = try? Data(contentsOf: url),
                                   let uiImage = UIImage(data: imageData) {
                                    
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 129, height: 200)
                                        .shadow(radius: 15)
                                        .cornerRadius(7)
                                } else {
                                    Image("placeholder-image")
                                }
                            }
                            
                            Text(movie.title + "\n")
                                .foregroundColor(.primary)
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                        }
                        .frame(width: 129, height: 300)
                    })
                }
            }
        }
        
        //        VStack(alignment: .leading, spacing: 16) {
        //            Text(title)
        //                .font(.title)
        //                .fontWeight(.bold)
        //                .padding(.horizontal)
        //
        //            ScrollView(.horizontal, showsIndicators: false) {
        //                HStack(alignment: .top, spacing: 16) {
        //                    ForEach(self.movies) { movie in
        //                        PosterCardView(movie: movie)
        ////                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
        ////                            PosterCardView(movie: movie)
        ////                        }.buttonStyle(PlainButtonStyle())
        ////                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
        ////                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
        //                    }
        //                }
        //            }
        //        }
    }
}

struct MovieSliderView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesOverviewView()
    }
}
