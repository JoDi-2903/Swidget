//
//  SmallSizeView.swift
//  RandomMovieWidgetExtension
//
//  Created by Jonathan Diebel on 05.06.22.
//

import SwiftUI
import WidgetKit

struct SmallSizeView: View {
    var entry: SimpleEntry
    let title: String
    let coverURL: URL?
    
    var body: some View {
        ZStack {
            Group {
                if let url = coverURL, let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("placeholder-image")
                }
            }
        }
        .overlay(TextOverlayView1(entry: entry, title: title))
    }
}
