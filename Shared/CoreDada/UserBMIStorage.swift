//
//  UserBMIStorage.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/10/23.
//

import Foundation
import CoreData

protocol UserBMIStorage {
    func updateUserBMI(_ user: User)
    func userDidLogBMI(date: Date, weight: Double, bmi: Double)
    func getMBILog() -> [BMILog]
}

class UserBMICoreDataStorage: UserBMIStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    // MARK: Update User BMI
    func updateUserBMI(_ user: User) {
        let managedContext = coreDataStorage.managedContext
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Log BMI change
    func userDidLogBMI(date: Date, weight: Double, bmi: Double) {
        let managedContext = coreDataStorage.managedContext
        
        let newBmiLog = BMILog(context: managedContext)
        newBmiLog.date = date
        newBmiLog.weight = weight
        newBmiLog.bmi = bmi
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getMBILog() -> [BMILog] {
        let managedContext = coreDataStorage.managedContext
        let fetchRequest = BMILog.fetchRequest()
        
        do {
            let bmiLog = try managedContext.fetch(fetchRequest)
            return bmiLog
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
