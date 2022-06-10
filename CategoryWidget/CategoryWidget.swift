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
    func category(for config: ConfigurationIntent) -> OverviewCategory {
        switch config.category {
        case .top_rated:
            return .top_rated
        case .popular:
            return .popular
        case .now_playing:
            return .now_playing
        case .upcoming:
            return .upcoming
        default:
            return .top_rated
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        //let conf = category(for: configuration)
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

public enum OverviewCategory: Int {
    case top_rated = 1
    case popular = 2
    case now_playing = 3
    case upcoming = 4
    
    func description() -> String {
        switch self {
        case .top_rated:
            return "Top Rated"
        case .popular:
            return "Popular"
        case .now_playing:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct CategoryWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
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
            CategoryWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            CategoryWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
