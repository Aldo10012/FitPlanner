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
}

protocol ProfilePresentorProtocol {
    mutating func updateProfile(completion: @escaping (ProfileVM?) -> () )
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
        print("BMI:", user?.bmi)
        
        feet = Int(height! / 12)
        inches = Int(height!) - Int(feet! * 12)
        
        
        // callback to update ProfileVC
        completion(self)
        
    }
}

// MARK: Interactor
extension ProfileVM: ProfileInteractorProtocol {
    
    func getUserData() -> User? {
        // Get user data form CoreData & return to presentor
        let user = myData.getUser()
        return user
    }
    
}

