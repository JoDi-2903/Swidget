//
//  CategoryWidget.swift
//  CategoryWidget
//
//  Created by Jonathan Diebel on 10.06.22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
//    func category(for config: ConfigurationIntent) -> OverviewCategory {
//        switch config.category {
//        case .top_rated:
//            return .top_rated
//        case .popular:
//            return .popular
//        case .now_playing:
//            return .now_playing
//        case .upcoming:
//            return .upcoming
//        default:
//            return .top_rated
//        }
//    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), movies: [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)])
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                //let conf = category(for: configuration)
                let movies = try await MovieDataService.shared.getMoviesFromCategory(category: "top_rated", language: nil)
                let entry = SimpleEntry(date: .now, configuration: configuration, movies: movies)
                completion(entry)
            } catch {
                let entry = SimpleEntry(date: .now, configuration: configuration, movies: [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)])
                completion(entry)
            }
        }
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let movies = try await MovieDataService.shared.getMoviesFromCategory(category: "top_rated", language: nil)
                let entry = SimpleEntry(date: .now, configuration: configuration, movies: movies)
                let currentDate = Date()
                let nextRefresh = Calendar.current.date(byAdding: .hour, value: +1, to: currentDate)!
                let timeline = Timeline(entries: [entry], policy: .after(nextRefresh))
                completion(timeline)
            } catch {
                let entry = SimpleEntry(date: .now, configuration: configuration, movies: [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)])
                let currentDate = Date()
                let nextRefresh = Calendar.current.date(byAdding: .hour, value: +1, to: currentDate)!
                let timeline = Timeline(entries: [entry], policy: .after(nextRefresh))
                completion(timeline)
            }
        }
    }
}

//public enum OverviewCategory: Int {
//    case top_rated = 1
//    case popular = 2
//    case now_playing = 3
//    case upcoming = 4
//
//    func description() -> String {
//        switch self {
//        case .top_rated:
//            return "Top Rated"
//        case .popular:
//            return "Popular"
//        case .now_playing:
//            return "Now Playing"
//        case .upcoming:
//            return "Upcoming"
//        }
//    }
//}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let movies: [Movie]
}

struct CategoryWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
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
struct CategoryWidget: Widget {
    let kind: String = "CategoryWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CategoryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Movie Overview")
        .description("Stay always up to date with this overview of categorized movies.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct CategoryWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), movies: [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            CategoryWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), movies: [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)]))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
