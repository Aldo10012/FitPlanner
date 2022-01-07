//
//  WorkoutPlanVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import UIKit


// MARK: Protocols
protocol WorkoutPlanInteractor {
    mutating func createWorkout()
    func editWorkout()
    func markWorkoutAsDone()
}

protocol WorkoutPlanPresentor {
    
}


// MARK: ViewModel
struct WorkoutPlanVM {
    fileprivate var myData = CoreDataStack()
    
    var name: String?
    var onSun: Bool?
    var onMon: Bool?
    var onTue: Bool?
    var onWed: Bool?
    var onThu: Bool?
    var onFri: Bool?
    var onSat: Bool?
    var exercises = [Exercise]()
    var alerts = [Alert]()
    
}

// MARK: Presentor
extension WorkoutPlanVM: WorkoutPlanPresentor {

}

// MARK: Interactor
extension WorkoutPlanVM: WorkoutPlanInteractor {
    
    mutating func createWorkout() {
        print("THis is where the magic happens")
        
        setupAlerts()
//        myData.createWorkout(
//            workoutName: name!,
//            onSun: onSun!, onMon: onMon!, onTue: onTue!, onWed: onWed!, onThu: onThu!, onFri: onFri!, onSat: onSat!,
//            alerts: alerts,
//            exercises: exercises)
        
    }
    
    func editWorkout() {
        print("edit workout")
    }
    
    func markWorkoutAsDone() {
        print("mark workout as done")
    }
    
    
    mutating func setupAlerts() {
        // setup viewModel.alerts based on which days are selected
    }
    
    
}


