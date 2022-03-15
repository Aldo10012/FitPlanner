//
//  MediumWidgetEntry.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI

// this is basically the Model / ViewModel for the widget
struct MediumWidgetEntry: TimelineEntry {
    let date: Date
    
    var nextWorkoutName: String
    var nextWorkoutDate: String
    var nextWorkout: Workout?
    var numberOfExercises: Int
}
