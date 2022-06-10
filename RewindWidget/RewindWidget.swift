//
//  RewindWidget.swift
//  RewindWidget
//
//  Created by Jonathan Diebel on 09.06.22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), movie: .placeholder(2), movieCrew: [.placeholder(1), .placeholder(2)])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                let movie = try await WidgetDataService.shared.getReleasedOnThisDay(yearsAgo: 5)
                let (_, movieCrew, _) = try await WidgetDataService.shared.getCreditsAndTrailerForMovie(movieId: movie.id)
                let entry = SimpleEntry(date: .now, movie: movie, movieCrew: movieCrew)
                completion(entry)
            } catch {
                let entry = SimpleEntry(date: .now, movie: .placeholder(2), movieCrew: [.placeholder(1), .placeholder(2)])
                completion(entry)
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        Task {
            var entries: [SimpleEntry] = []
            let reloadTimes: [Int] = [0, 8, 10, 12, 14, 16, 18, 20, 22]
            let yearsAgo: [Int] = [2, 3, 5, 7, 10, 12, 15, 20, 30]
            let currentDate = Date()
            
            do {
                for scheduleNumber in 0 ... 8 {
                    let entryDate = Calendar.current.date(bySettingHour: reloadTimes[scheduleNumber], minute: 0, second: 0, of: currentDate)!
                    let movie = try await WidgetDataService.shared.getReleasedOnThisDay(yearsAgo: yearsAgo[scheduleNumber])
                    let (_, movieCrew, _) = try await WidgetDataService.shared.getCreditsAndTrailerForMovie(movieId: movie.id)
                    let entry = SimpleEntry(date: entryDate, movie: movie, movieCrew: movieCrew)
                    entries.append(entry)
                }
            } catch {
                let entry = SimpleEntry(date: .now, movie: .placeholder(2), movieCrew: [.placeholder(1), .placeholder(2)])
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let movie: Movie
    let movieCrew: [MovieCrew]
}

struct RewindWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallSizeView(entry: entry)
        case .systemMedium:
            MediumSizeView(entry: entry)
        case .systemLarge:
            LargeSizeView(entry: entry)
        default:
            Text("Not implemented!")
        }
    }
}

@main
struct RewindWidget: Widget {
    let kind: String = "RewindWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RewindWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Rewind Time")
        .description("Throwback to past movies that were released exactly on today's date.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct RewindWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RewindWidgetEntryView(entry: SimpleEntry(date: Date(), movie: .placeholder(2), movieCrew: [.placeholder(1), .placeholder(2)]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            RewindWidgetEntryView(entry: SimpleEntry(date: Date(), movie: .placeholder(2), movieCrew: [.placeholder(1), .placeholder(2)]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            RewindWidgetEntryView(entry: SimpleEntry(date: Date(), movie: .placeholder(2), movieCrew: [.placeholder(1), .placeholder(2)]))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
