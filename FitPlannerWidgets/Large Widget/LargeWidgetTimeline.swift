//
//  LargeWidgetTimeline.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI

/// Creates one or more timeline entries with dates that tell WidgetKit when to display a widget.
struct LargeWidgetTimeline: TimelineProvider {
    
    let workoutStorage = WorkoutCoreDataStorage()
    
    /// return our snapshotEntry
    func placeholder(in context: Context) -> LargeWidgetEntry {
        LargeWidgetEntry(
            date: Date(),
            nextWorkoutName: "",
            nextWorkoutDate: "",
            nextWorkout: nil,
            numberOfExercises: 0
        )
    }

    /// create the snapshot using the snapshotEntry
    func getSnapshot(in context: Context, completion: @escaping (LargeWidgetEntry) -> ()) {
        let entry = LargeWidgetEntry(
            date: Date(),
            nextWorkoutName: "",
            nextWorkoutDate: "",
            nextWorkout: nil,
            numberOfExercises: 0
        )
        completion(entry)
    }

    /// specify a timeline, with several entries using real data
    func getTimeline(in context: Context, completion: @escaping (Timeline<LargeWidgetEntry>) -> ()) {
        var entries: [LargeWidgetEntry] = []

        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = createlargeWidgetEntry(entryDate: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    
    func createlargeWidgetEntry(entryDate: Date) -> LargeWidgetEntry {
        var entry: LargeWidgetEntry!
        
        if let nextWorkout = workoutStorage.getNextWorkout() {
            entry = LargeWidgetEntry(
                date: entryDate,
                nextWorkoutName: nextWorkout.name!,
                nextWorkoutDate: Date().getDateAsString(dateOfNextWorkout, format: "EEEE"),
                nextWorkout: nextWorkout,
                numberOfExercises: nextWorkout.exercises?.count ?? 0,
                onSun: nextWorkout.onSun,
                onMon: nextWorkout.onMon,
                onTue: nextWorkout.onTue,
                onWed: nextWorkout.onWed,
                onThu: nextWorkout.onThu,
                onFri: nextWorkout.onFri,
                onSat: nextWorkout.onSat
            )
        } else {
            entry = LargeWidgetEntry(
                date: entryDate,
                nextWorkoutName: "No workouts ",
                nextWorkoutDate: "",
                numberOfExercises: 0
            )
        }
        print(entry)
        return entry
    }
}
