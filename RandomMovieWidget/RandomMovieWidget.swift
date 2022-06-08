//
//  RandomMovieWidget.swift
//  RandomMovieWidget
//
//  Created by Jonathan Diebel on 04.06.22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), movie: .placeholder(42))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
//            let movieDetailState = MovieDetailState()
//            movieDetailState.loadMovie(id: 675353)
//            let movie = movieDetailState.movie
            let entry = SimpleEntry(date: .now, movie: .placeholder(42))
            completion(entry)
            
            //            let movieDetailState = MovieDetailState()
            //            movieDetailState.loadMovie(id: 675353)
            //            let movie = movieDetailState.movie!
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let movie = MovieDetailState().loadMovie(id: 675353) // Fehler: loadMovie ist void
                
                let entry = SimpleEntry(date: .now, movie: .placeholder(1))
                
                //                let movieDetailState = MovieDetailState()
                //                movieDetailState.loadMovie(id: 675353)
                //                let entry = SimpleEntry(date: .now, movie: movieDetailState.movie
                
                // Construct a timeline with a single entry and tell it to refresh after some spacific date has passed
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 60 * 30)))
                completion(timeline)
            } catch {
                let entry = SimpleEntry(date: .now, movie: .placeholder(0))
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 60 * 30)))
                completion(timeline)
            }
        }
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let movie: Movie
}

struct RandomMovieWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallSizeView(entry: entry)
        case .systemMedium:
            MediumSizeView(entry: entry)
        default:
            Text("Not implemented!")
        }
    }
}

@main
struct RandomMovieWidget: Widget {
    let kind: String = "RandomMovieWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RandomMovieWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Movie")
        .description("Discover new movies throughout your day.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct RandomMovieWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RandomMovieWidgetEntryView(entry: SimpleEntry(date: Date(), movie: .placeholder(42)))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            RandomMovieWidgetEntryView(entry: SimpleEntry(date: Date(), movie: .placeholder(42)))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.colorScheme, .light)
        }
    }
}
