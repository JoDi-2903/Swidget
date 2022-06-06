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
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct RandomMovieWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    let movieTitle = "Bloodshot"
    let movieYear = "2020"
    let coverURL = URL(string: "https://image.tmdb.org/t/p/w500/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg")
    let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg")

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallSizeView(entry: entry, title: movieTitle, coverURL: coverURL)
        case .systemMedium:
            MediumSizeView(entry: entry, title: movieTitle, year: movieYear, backdropURL: backdropURL)
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
            RandomMovieWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            RandomMovieWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.colorScheme, .light)
        }
    }
}
