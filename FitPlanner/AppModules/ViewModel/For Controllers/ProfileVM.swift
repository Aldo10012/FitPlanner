//
//  ProfileVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import UIKit

// MARK: Protocols
protocol ProfileInteractorProtocol {
    func getUserData() -> User?
    func updateUserBMI(for user: User)
}

protocol ProfilePresentorProtocol {
    mutating func updateProfile(completion: @escaping (ProfileVM?) -> () )
    mutating func updateBMI(newWeight: Double)
}


// MARK: View Model
struct ProfileVM {
    fileprivate let myData = CoreDataStack.shared
    
    var profilePic: UIImage?
    var userName: String?
    var weight: Double?
    var height: Double? // in inches
    var feet: Int?
    var inches: Int?
    var bmi: Double?
    
    init() {
        
    }
}

// MARK: Presentor
extension ProfileVM: ProfilePresentorProtocol {
        
    mutating func updateProfile(completion: @escaping (ProfileVM?) -> () ) {
        
        // call interactor to get data from CoreData
        let user = getUserData()
        
        // update properties for view model
        profilePic = UIImage(data: (user?.pictureData)!)
        userName = user?.name
        weight = user?.weight
        height = user?.height
        
        bmi = Double(round(user!.bmi * 100) / 100.0)
        feet = Int(height! / 12)
        inches = Int(height!) - Int(feet! * 12)
        
        
        // callback to update ProfileVC
        completion(self)
        
    }
    
    mutating func updateBMI(newWeight: Double) {
        weight = newWeight
        
        let user = getUserData()
        let newBMI = BMIMannager.calculateBMI(height: height!, weight: newWeight)
        user?.bmi = newBMI
        user?.weight = newWeight
        
        updateUserBMI(for: user!)
        
    }
}

// MARK: Interactor
extension ProfileVM: ProfileInteractorProtocol {
    
    func getUserData() -> User? {
        // Get user data form CoreData & return to presentor
        let user = myData.getUser()
        return user
    }
    
    func updateUserBMI(for user: User) {
        myData.updateUserBMI(user)
    }
    
}

