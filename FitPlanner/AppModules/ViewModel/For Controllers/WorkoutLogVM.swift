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
    mutating func onViewDidLoad(completion: @escaping() -> ())
}

protocol WorkoutLogInteractor {
    func getWorkouts() -> [Workout]
}


// MARK: ViewModel
struct WorkoutLogVM {
    fileprivate var myData = CoreDataStack()

    
    var yourWorkouts: [WorkoutCardVM] = []
    

}

// MARK: Presentor
extension WorkoutLogVM: WorkoutLogPresentor {
    mutating func onViewDidLoad(completion: @escaping() -> ()) {
        
        // Get workouts from Interactor
        let usersWorkouts = getWorkouts()
        
        // Manipulate viewModel as needed
        for w in usersWorkouts {
            yourWorkouts.append(
                WorkoutCardVM(workout: w, title: w.name, onSun: w.onSun, onMon: w.onMon, onTue: w.onTue, onWed: w.onWed, onThu: w.onThu, onFri: w.onFri, onSat: w.onSat)
            )
        }
        
        // Update View
        completion()
    }
}

// MARK: Interactor
extension WorkoutLogVM: WorkoutLogInteractor {

    func getWorkouts() -> [Workout] {
        return myData.getWorkouts()
    }
}
