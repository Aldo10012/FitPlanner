//
//  CoreDataStack.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import CoreData
import Foundation
import UIKit
import WidgetKit

// inspired by https://codereview.stackexchange.com/questions/220783/core-data-wrapper

class NSCustomPersistentContainer: NSPersistentContainer {
    // https://medium.com/@manibatra23/sharing-data-using-core-data-ios-app-and-extension-fb0a176eaee9
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Alberto-Dominguez.FitPlanner")
        storeURL = storeURL?.appendingPathComponent("FitPlanner.sqlite")
        return storeURL!
    }

}


struct CoreDataStack {
    
    static let shared = CoreDataStack()
    
//    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    lazy var managedContext = self.persistentContainer.viewContext
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSCustomPersistentContainer(name: "FitPlanner")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: Create user
    func registerNewUser(userName: String, height: Double, weight: Double, pictureData: Data) {
        let managedContext = persistentContainer.viewContext
        
        let newUser = User(context: managedContext)
        newUser.name = userName
        newUser.height = height
        newUser.weight = weight
        newUser.pictureData = pictureData
        
        // save context
        do { 
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: Get user
    func getUser() -> User? {
        let managedContext = persistentContainer.viewContext
        
        // Prepare fetchRequest
        let fetchRequest = User.fetchRequest()
        
        do {
            let result = try managedContext.fetch(fetchRequest)  // get User
            return result.first                                  // return User
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    // MARK: Create Workout
    func createWorkout(workoutName: String,
                       onSun: Bool, onMon: Bool, onTue: Bool, onWed: Bool, onThu: Bool, onFri: Bool, onSat: Bool,
                       alerts: [Alert], exercises: [Exercise]
    ) {
        let managedContext = persistentContainer.viewContext
        
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
        
        // save context
        do {
            try managedContext.save()
            WidgetCenter.shared.reloadAllTimelines()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: Get workouts
    func getWorkouts() -> [Workout] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = Workout.fetchRequest()
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    // MARK: Update Workout
    func updateWorkout(_ workout: Workout) {
        let managedContext = persistentContainer.viewContext
//        workout
        do {
            try managedContext.save()
            WidgetCenter.shared.reloadAllTimelines()
        }
        catch {}
    }
    
    // MARK: - Delete Workout
    func deleteWorkout(_ workout: Workout) {
        let managedContext = persistentContainer.viewContext
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
    
    // MARK: Get Next Workout
    func getNextWorkout() -> Workout? {
        let managedContext = persistentContainer.viewContext
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
    
    
    // MARK: Get Activity
    func getActivity() -> [Activity] {
        let managedContext = persistentContainer.viewContext
        
        // Prepare fetchRequest
        let fetchRequest = Activity.fetchRequest()
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func completedWorkout() {
        let managedContext = persistentContainer.viewContext
        
        let newActivity = Activity(context: managedContext)
        newActivity.date = Date.today().previous(.thursday)
        newActivity.complete = true
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    // MARK: Helpers
    func findNextWorkout(from workouts: [Workout]) -> Workout? {
//        if workouts.count == 0 { return nil }
        
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
    
    func checkIf(workout: Workout, isOn dateSelected: Date) -> Workout? {
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


