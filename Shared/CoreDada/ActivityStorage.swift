//
//  ActivityStorage.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/10/23.
//

import Foundation
import CoreData

protocol ActivityStorage {
    func getActivity() -> [Activity]
    func completedWorkout()
}

class ActivityCoreDataStorage: ActivityStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    // MARK: Get Activity
    func getActivity() -> [Activity] {
        let managedContext = coreDataStorage.managedContext
        
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
        let managedContext = coreDataStorage.managedContext
        
        let newActivity = Activity(context: managedContext)
        newActivity.date = Date.today()
        newActivity.complete = true
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
