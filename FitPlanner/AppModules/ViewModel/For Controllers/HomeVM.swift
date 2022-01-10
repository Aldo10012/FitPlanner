//
//  HomeVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import Foundation
import CoreData

// MARK: Protocols
protocol HomePresentor {
    mutating func updateNextWorkoutCard(completion: @escaping(Result<String, String>) -> ())
    mutating func updateActivityCalendar(completion: @escaping(Result<String, String>) -> ())
}

protocol HomeInteractor {
    var myData: CoreDataStack { get }
    func getNextWorkout() -> Workout?
    func getActivity() -> [Activity]?
}


// MARK: ViewModel
struct HomeVM {
    var nextWorkout = WorkoutCardVM()
    var activity: [Activity]? = []
}


// MARK: Presentor
extension HomeVM: HomePresentor {
    
    mutating func updateNextWorkoutCard(completion: @escaping(Result<String, String>) -> ()) {
        print("")
        let nextWorkout = getNextWorkout()
        self.nextWorkout.workout = nextWorkout
    }
    
    mutating func updateActivityCalendar(completion: @escaping (Result<String, String>) -> ()) {
        print("")
        self.activity = getActivity()
    }
}


// MARK: Interactor
extension HomeVM: HomeInteractor {
    var myData: CoreDataStack { return CoreDataStack() }
    
    func getNextWorkout() -> Workout? {
        print("")
        // TODO: get next workout
        // if there is a workout, return it, else, return nil
        return nil
    }
    
    func getActivity() -> [Activity]? {
        return nil
    }
}

