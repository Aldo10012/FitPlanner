//
//  UsersStorage.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/10/23.
//

import Foundation
import CoreData

protocol UsersStorage {
    func registerNewUser(userName: String, height: Double, weight: Double, pictureData: Data)
    func getUser() -> User?
}

class UserCoreDataStorage: UsersStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func registerNewUser(userName: String, height: Double, weight: Double, pictureData: Data) {
        let managedContext = coreDataStorage.managedContext
        
        let newUser = User(context: managedContext)
        newUser.name = userName
        newUser.height = height
        newUser.weight = weight
        newUser.bmi = BMIMannager.calculateBMI(height: height, weight: weight)
        newUser.pictureData = pictureData
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getUser() -> User? {
        let managedContext = coreDataStorage.managedContext
        
        let fetchRequest = User.fetchRequest()
        do {
            let result = try managedContext.fetch(fetchRequest)  // get User
            return result.first                                  // return User
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}
