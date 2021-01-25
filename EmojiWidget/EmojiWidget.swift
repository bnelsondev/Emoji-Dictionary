//
//  EmojiWidget.swift
//  EmojiWidget
//
//  Created by Bryan Nelson on 1/24/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: getEmojis().randomElement()!)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: getEmojis().randomElement()!)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: getEmojis().randomElement()!)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: Emoji
}

struct EmojiWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.emoji.character).font(.system(size: 100))
            Text(entry.emoji.definition).font(.title).minimumScaleFactor(0.2)
            Text(String(repeating: "⭐️", count: Int(entry.emoji.rating))).padding(.bottom,10)
        }
    }
}

@main
struct EmojiWidget: Widget {
    let kind: String = "EmojiWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmojiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Dictionary")
        .description("Displays a random Emoji every hour!")
    }
}

struct EmojiWidget_Previews: PreviewProvider {
    static var previews: some View {
        EmojiWidgetEntryView(entry: SimpleEntry(date: Date(), emoji: getEmojis().randomElement()!))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
