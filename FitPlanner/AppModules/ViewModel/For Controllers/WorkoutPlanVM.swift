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
        
        setupAlertsAndNotifications()
//        print("MY EXERCISES: \n", exercises)
        myData.createWorkout(
            workoutName: name!,
            onSun: onSun!, onMon: onMon!, onTue: onTue!, onWed: onWed!, onThu: onThu!, onFri: onFri!, onSat: onSat!,
            alerts: alerts,
            exercises: exercises)
        
    }
    
    func editWorkout() {
        print("edit workout")
    }
    
    func markWorkoutAsDone() {
        print("mark workout as done")
    }
    
    
    mutating func setupAlertsAndNotifications() {
        // 1. update viewModel.alerts based on which days are selected
        if onSun! { createAndAppendAlert(dayOfWeek: .sunday) }
        if onMon! { createAndAppendAlert(dayOfWeek: .monday) }
        if onTue! { createAndAppendAlert(dayOfWeek: .tuesday) }
        if onWed! { createAndAppendAlert(dayOfWeek: .wednesday) }
        if onThu! { createAndAppendAlert(dayOfWeek: .thursday) }
        if onFri! { createAndAppendAlert(dayOfWeek: .friday) }
        if onSat! { createAndAppendAlert(dayOfWeek: .saturday) }
        
        func createAndAppendAlert(dayOfWeek: Weekday) {
            let date = Date.today().next(dayOfWeek)
            let newAlert = Alert(context: myData.managedContext)
            newAlert.date = date
            alerts.append(newAlert)
        }
        
        
        
        // 2. setup local notification based on viewModel.alerts[i].date
//        let notificationManager = NotificationManager()
//
//        for alert in alerts {
//            notificationManager.setupLocalNotification(name: name!, date: alert.date!)
//        }
    }
    
    
}
