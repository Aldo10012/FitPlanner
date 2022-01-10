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
    mutating func updateActivityCalendar(completion: @escaping() -> ())
}

protocol HomeInteractor {
    var myData: CoreDataStack { get }
    func getNextWorkout() -> Workout?
    func getActivity() -> [Activity]
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
        let theNextWorkout = getNextWorkout()
        if theNextWorkout == nil { completion(Result.failure("fail"))}
        
        self.nextWorkout.workout = theNextWorkout
        self.nextWorkout.title = theNextWorkout?.name
        
        self.nextWorkout.onSun = theNextWorkout?.onSun
        self.nextWorkout.onMon = theNextWorkout?.onMon
        self.nextWorkout.onTue = theNextWorkout?.onTue
        self.nextWorkout.onWed = theNextWorkout?.onWed
        self.nextWorkout.onThu = theNextWorkout?.onThu
        self.nextWorkout.onFri = theNextWorkout?.onFri
        self.nextWorkout.onSat = theNextWorkout?.onSat
        
        completion(Result.success("success"))
    }
    
    mutating func updateActivityCalendar(completion: @escaping () -> ()) {
        print("")
        self.activity = getActivity()
        completion()
    }
}


// MARK: Interactor
extension HomeVM: HomeInteractor {
    var myData: CoreDataStack { return CoreDataStack() }
    
    func getNextWorkout() -> Workout? {
        print("")
        return myData.getNextWorkout()
    }
    
    func getActivity() -> [Activity] {
        return myData.getActivity()
    }
}

