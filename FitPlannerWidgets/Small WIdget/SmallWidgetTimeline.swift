//
//  SmallWidgetTimeline.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/12/22.
//

import WidgetKit
import SwiftUI

struct SmallWidgetTimeline: TimelineProvider {
    
    /// return our snapshotEntry
    func placeholder(in context: Context) -> SmallWidgetEntry {
        SmallWidgetEntry(date: Date(), nextWorkoutName: "", nextWorkoutDate: "")
    }

    /// create the snapshot using the snapshotEntry
    func getSnapshot(in context: Context, completion: @escaping (SmallWidgetEntry) -> ()) {
        let entry = SmallWidgetEntry(date: Date(), nextWorkoutName: "", nextWorkoutDate: "")
        completion(entry)
    }

    /// specify a timeline, with several entries using real data
    func getTimeline(in context: Context, completion: @escaping (Timeline<SmallWidgetEntry>) -> ()) {
        var entries: [SmallWidgetEntry] = []

        let myData = CoreDataStack.shared
        var name: String
        var date: String
        
        print("next workout:", myData.getNextWorkout() )
        if let nextWorkout = myData.getNextWorkout() {
            name = nextWorkout.name!
            date = getDateAsStringLong(dateOfNextWorkout)
        } else {
            name = "No workouts "
            date = ""
            
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SmallWidgetEntry(
                date: entryDate,
                nextWorkoutName: name,
                nextWorkoutDate: date
            )
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
