//
//  SmallWIdgetEntry.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/12/22.
//

import WidgetKit
import SwiftUI

// this is basically the Model / ViewModel for the widget
struct SmallWidgetEntry: TimelineEntry {
    let date: Date
    var nextWorkoutName: String
    var nextWorkoutDate: String
}
