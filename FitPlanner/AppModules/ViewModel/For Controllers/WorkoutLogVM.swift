//
//  WorkoutLogVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import Foundation
import CoreData


// MARK: Protocols
protocol WorkoutLogPresentor {
    mutating func onViewDidLoad()
}

protocol WorkoutLogInteractor {
    func getWorkouts() -> [Workout]
}


// MARK: ViewModel
struct WorkoutLogVM {
    fileprivate var myData = CoreDataStack()

    
    var yourWorkouts: [WorkoutCardVM] = [
        WorkoutCardVM(title: "Workout A", onSun: false, onMon: true, onTue: false, onWed: true, onThu: false, onFri: true, onSat: false),
        WorkoutCardVM(title: "Workout B", onSun: true, onMon: false, onTue: true, onWed: false, onThu: true, onFri: false, onSat: true)
    ]
    

}

// MARK: Presentor
extension WorkoutLogVM: WorkoutLogPresentor {
    mutating func onViewDidLoad() {
        
        // Get workouts from Interactor
        let usersWorkouts = getWorkouts()
        
        // Manipulate viewModel as needed
        for w in usersWorkouts {
            yourWorkouts.append(
                WorkoutCardVM(title: w.name, onSun: w.onSun, onMon: w.onMon, onTue: w.onTue, onWed: w.onWed, onThu: w.onThu, onFri: w.onFri, onSat: w.onSat)
            )
        }
        
        // Update View
    }
}

// MARK: Interactor
extension WorkoutLogVM: WorkoutLogInteractor {

    func getWorkouts() -> [Workout] {
        return myData.getWorkouts()
    }
}
