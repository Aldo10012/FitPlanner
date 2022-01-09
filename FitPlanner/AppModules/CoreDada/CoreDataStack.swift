//
//  CoreDataStack.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import CoreData
import Foundation
import UIKit

// inspired by https://codereview.stackexchange.com/questions/220783/core-data-wrapper

struct CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: Create user
    func registerNewUser(userName: String, height: Double, weight: Double, pictureData: Data) {
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
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: Get workouts
    func getWorkouts() -> [Workout] {
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
//        workout
        do {
            try managedContext.save()
        }
        catch {}
    }
    
    // MARK: - Delete todo
    func deleteWorkout(_ workout: Workout) {
        do {
            try managedContext.delete(workout)
            for alert in workout.alerts! {
                let id: String = workout.name! + "-" + getDateAsString((alert as! Alert).date!)
                NotificationManager().deleteNotification(withID: id)
            }
                        
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    
}
