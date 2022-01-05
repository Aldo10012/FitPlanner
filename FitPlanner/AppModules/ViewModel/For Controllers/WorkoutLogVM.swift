//
//  WorkoutLogVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import Foundation

struct WorkoutLogVM {
    
    var yourWorkouts: [WorkoutCardVM] = [
        WorkoutCardVM(title: "Workout A", onSun: false, onMon: true, onTue: false, onWed: true, onThu: false, onFri: true, onSat: false),
        WorkoutCardVM(title: "Workout B", onSun: true, onMon: false, onTue: true, onWed: false, onThu: true, onFri: false, onSat: true)
    ]
}
