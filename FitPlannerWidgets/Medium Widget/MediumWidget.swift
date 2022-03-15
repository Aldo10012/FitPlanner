//
//  MediumWidget.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI


struct MediumWidget: Widget {
    let kind: String = "FitPlannerWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MediumWidgetTimeline()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Medium Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetEntryView(entry: MediumWidgetEntry(
            date: Date(),
            nextWorkoutName: MediumSample.getName(),
            nextWorkoutDate: getDateAsStringLong(Date()),
            nextWorkout: MediumSample.getListofExercises(),
            numberOfExercises: MediumSample.getNumberOfExercises()
        ))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


fileprivate class MediumSample {
    static func getName() -> String {
        let myData = CoreDataStack.shared
        let nextWorkout = myData.getNextWorkout()
        
        if nextWorkout?.name == nil {
            return "not found"
        } else {
            return (nextWorkout?.name!)!
        }
    }

    static func getListofExercises() -> Workout? {
        let myData = CoreDataStack.shared
        let nextWorkout = myData.getNextWorkout()
        
        return nextWorkout
    }

    static func getNumberOfExercises() -> Int {
        let myData = CoreDataStack.shared
        let nextWorkout = myData.getNextWorkout()
        let numberOfExercises = nextWorkout?.exercises?.count
        
        if numberOfExercises == nil {
            return 0
        } else {
            return numberOfExercises!
        }
    }
}



