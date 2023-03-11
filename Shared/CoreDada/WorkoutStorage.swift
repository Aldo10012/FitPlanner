//
//  WorkoutStorage.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/10/23.
//

import Foundation
import CoreData
import WidgetKit

protocol WorkoutStorage {
    func createWorkout(workoutName: String,
                       onSun: Bool, onMon: Bool, onTue: Bool, onWed: Bool, onThu: Bool, onFri: Bool, onSat: Bool,
                       alerts: [Alert], exercises: [Exercise])
    func getAllWorkouts() -> [Workout]
    func getNextWorkout() -> Workout?
    func updateWorkout(_ workout: Workout)
    func deleteWorkout(_ workout: Workout)
}

class WorkoutCoreDataStorage: WorkoutStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func createWorkout(workoutName: String,
                       onSun: Bool, onMon: Bool, onTue: Bool, onWed: Bool, onThu: Bool, onFri: Bool, onSat: Bool,
                       alerts: [Alert], exercises: [Exercise]) {
        let managedContext = coreDataStorage.managedContext
        
        let newWorkout = Workout(context: managedContext)
        newWorkout.name = workoutName
        newWorkout.onSun = onSun
        newWorkout.onMon = onMon
        newWorkout.onTue = onTue
        newWorkout.onWed = onWed
        newWorkout.onThu = onThu
        newWorkout.onFri = onFri
        newWorkout.onSat = onSat
        
        newWorkout.alerts = NSSet(array: alerts)
        newWorkout.exercises = NSSet(array: exercises)
        
        do {
            try managedContext.save()
            WidgetCenter.shared.reloadAllTimelines()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllWorkouts() -> [Workout] {
        let managedContext = coreDataStorage.managedContext
        let fetchRequest = Workout.fetchRequest()
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func getNextWorkout() -> Workout? {
        let managedContext = coreDataStorage.managedContext
        let fetchRequest = Workout.fetchRequest()
        print(fetchRequest)
        //let futureWorkouts = NSPredicate(format: "date > %@", Date.today() as CVarArg)
        
        do {
            let allWorkouts = try managedContext.fetch(fetchRequest)
            let nextWorkout = findNextWorkout(from: allWorkouts)
            return nextWorkout
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func updateWorkout(_ workout: Workout) {
        let managedContext = coreDataStorage.managedContext
        do {
            try managedContext.save()
            WidgetCenter.shared.reloadAllTimelines()
        }
        catch {}
    }
    
    func deleteWorkout(_ workout: Workout) {
        let managedContext = coreDataStorage.managedContext
        do {
            try managedContext.delete(workout)
            for alert in workout.alerts! {
                let id: String = workout.name! + "-" + getDateAsString((alert as! Alert).date!)
                NotificationManager().deleteNotification(withID: id)
            }
            
            try managedContext.save()
            WidgetCenter.shared.reloadAllTimelines()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}

extension WorkoutCoreDataStorage {
    private func findNextWorkout(from workouts: [Workout]) -> Workout? {
        // if workouts.count == 0 { return nil }
        for workout in workouts {
            if (checkIf(workout: workout, isOn: Date.today()) != nil) {
                return workout
            }
            else if (checkIf(workout: workout, isOn: Date().skip(numOfDays: 1)) != nil) {
                return workout
            }
            else if (checkIf(workout: workout, isOn: Date().skip(numOfDays: 2)) != nil) {
                return workout
            }
            else if (checkIf(workout: workout, isOn: Date().skip(numOfDays: 3)) != nil) {
                return workout
            }
            else if (checkIf(workout: workout, isOn: Date().skip(numOfDays: 4)) != nil) {
                return workout
            }
            else if (checkIf(workout: workout, isOn: Date().skip(numOfDays: 5)) != nil) {
                return workout
            }
            else if (checkIf(workout: workout, isOn: Date().skip(numOfDays: 6)) != nil) {
                return workout
            }
        }
        
        return nil
    }
    
    private func checkIf(workout: Workout, isOn dateSelected: Date) -> Workout? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee"
        
        let selectedDate = getDateAsString(dateSelected)
        
        let listofAlerts = (workout.alerts)?.allObjects as! [Alert]
        for alert in listofAlerts {
            let yourWorkoutDate = getDateAsString(alert.date!)
            
            if selectedDate == yourWorkoutDate {
                dateOfNextWorkout = dateSelected
                return workout
            }
        }
        
        return nil
    }
}
