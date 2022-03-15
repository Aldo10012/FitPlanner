//
//  MediumWidgetTimeline.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI

/// Creates one or more timeline entries with dates that tell WidgetKit when to display a widget.
struct MediumWidgetTimeline: TimelineProvider {
    
    let myData = CoreDataStack.shared
    
    /// return our snapshotEntry
    func placeholder(in context: Context) -> MediumWidgetEntry {
        MediumWidgetEntry(
            date: Date(),
            nextWorkoutName: "",
            nextWorkoutDate: "",
            nextWorkout: nil,
            numberOfExercises: 0
        )
    }

    /// create the snapshot using the snapshotEntry
    func getSnapshot(in context: Context, completion: @escaping (MediumWidgetEntry) -> ()) {
        let entry = MediumWidgetEntry(
            date: Date(),
            nextWorkoutName: "",
            nextWorkoutDate: "",
            nextWorkout: nil,
            numberOfExercises: 0
        )
        completion(entry)
    }

    /// specify a timeline, with several entries using real data
    func getTimeline(in context: Context, completion: @escaping (Timeline<MediumWidgetEntry>) -> ()) {
        var entries: [MediumWidgetEntry] = []

        
        var name: String
        var date: String
        var workout: Workout?
        var numberOfExercises: Int
        
        print("next workout:", myData.getNextWorkout() )
        if let nextWorkout = myData.getNextWorkout() {
            name = nextWorkout.name!
            date = getDateAsStringLong(dateOfNextWorkout) + ",\n" + getMonthAndDateAsString(dateOfNextWorkout)
            workout = nextWorkout
            numberOfExercises = nextWorkout.exercises?.count ?? 0
        } else {
            name = "No workouts "
            date = ""
            workout = nil
            numberOfExercises = 0
            
        }
        
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = MediumWidgetEntry(
                date: entryDate,
                nextWorkoutName: name,
                nextWorkoutDate: date,
                nextWorkout: workout,
                numberOfExercises: numberOfExercises
            )
            
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
