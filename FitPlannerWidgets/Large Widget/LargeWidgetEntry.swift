//
//  LargeWidgetEntry.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI

// this is basically the Model / ViewModel for the widget
struct LargeWidgetEntry: TimelineEntry {
    let date: Date
    
    var nextWorkoutName: String
    var nextWorkoutDate: String
    var nextWorkout: Workout?
    var numberOfExercises: Int
    
    var onSun: Bool = false
    var onMon: Bool = false
    var onTue: Bool = false
    var onWed: Bool = false
    var onThu: Bool = false
    var onFri: Bool = false
    var onSat: Bool = false
}
