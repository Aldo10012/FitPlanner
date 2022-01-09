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
    mutating func editWorkout()
    func markWorkoutAsDone()
}

protocol WorkoutPlanPresentor {
    
}


// MARK: ViewModel
struct WorkoutPlanVM {
    fileprivate var myData = CoreDataStack()
    var object: Workout?
    
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
    
    mutating func editWorkout() {
        print("edit workout")
        object?.name = name
        object?.onSun = onSun!
        object?.onMon = onMon!
        object?.onTue = onTue!
        object?.onWed = onWed!
        object?.onThu = onThu!
        object?.onFri = onFri!
        object?.onSat = onSat!
        object?.exercises = NSSet(array: exercises)
        self.deleteOldAlertsAndSetNewOnes()
        
        myData.updateWorkout(object!)
        
    }
    
    func markWorkoutAsDone() {
        print("mark workout as done")
    }
    
    
    // MARK: Helpers
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
        let notificationManager = NotificationManager()
//
        for alert in alerts {
            let idString: String = name! + "-" + getDateAsString(alert.date!)
            
            notificationManager.setupLocalNotification(
                name: name!,
                date: alert.date!, id: idString)
        }
    }
    
    mutating func deleteOldAlertsAndSetNewOnes() {
        // clear notifications
        for alert in alerts {
            let idString: String = name! + "-" + getDateAsString(alert.date!)
            NotificationManager().deleteNotification(withID: idString)
        }
        // clear object alerts
        self.object?.alerts = []
        
        // new alerts & notifications
        self.setupAlertsAndNotifications()
        self.object?.alerts = NSSet(array: self.alerts)
    }
    
    
}
