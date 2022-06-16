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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), movies: [.placeholder(1), .placeholder(2), .placeholder(3), .placeholder(4)])
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                let selectedCategory: String = SelectedCategory(rawValue: configuration.category.rawValue)!.categoryValue
                let selectedLanguage: String = SelectedLanguage(rawValue: configuration.language.rawValue)!.languageValue
                
                let movies = try await MovieDataService.shared.getMoviesFromCategory(category: selectedCategory, language: selectedLanguage)
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
                let selectedCategory: String = SelectedCategory(rawValue: configuration.category.rawValue)!.categoryValue
                let selectedLanguage: String = SelectedLanguage(rawValue: configuration.language.rawValue)!.languageValue
                
                let movies = try await MovieDataService.shared.getMoviesFromCategory(category: selectedCategory, language: selectedLanguage)
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

enum SelectedCategory: Int {
    case top_rated = 1
    case popular = 2
    case now_playing = 3
    case upcoming = 4
}
extension SelectedCategory {
    var categoryValue: String {
        switch self {
        case .top_rated:
            return "top_rated"
        case .popular:
            return "popular"
        case .now_playing:
            return "now_playing"
        case .upcoming:
            return "upcoming"
        }
    }
}

enum SelectedLanguage: Int {
    case en_US = 1
    case de_DE = 2
}
extension SelectedLanguage {
    var languageValue: String {
        switch self {
        case .en_US:
            return "en_US"
        case .de_DE:
            return "de_DE"
        }
    }
}

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
