//
//  SmallWidgetTimeline.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/12/22.
//

import WidgetKit
import SwiftUI

struct SmallWidgetTimeline: TimelineProvider {
    func placeholder(in context: Context) -> SmallWidgetEntry {
        SmallWidgetEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SmallWidgetEntry) -> ()) {
        let entry = SmallWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SmallWidgetEntry>) -> ()) {
        var entries: [SmallWidgetEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SmallWidgetEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
