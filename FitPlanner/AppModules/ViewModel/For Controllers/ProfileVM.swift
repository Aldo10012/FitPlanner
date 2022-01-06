//
//  ProfileVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import UIKit

// MARK: Protocols
protocol ProfileInteractor {
    mutating func getUserData()
}

protocol ProfilePresentor {
    mutating func updateProfile(completion: @escaping (ProfileVM?) -> () )
}


// MARK: View Model
struct ProfileVM {
    fileprivate let myData = CoreDataStack()
    
    var profilePic: UIImage?
    var userName: String?
    var weight: Double?
    var height: Double?
    
    init() {
        
    }
}

// MARK: Presentor
extension ProfileVM: ProfilePresentor {
    mutating func updateProfile(completion: @escaping (ProfileVM?) -> () ) {
        print("update views on PrifileVC")
        getUserData()      // calls interactor to get data
        completion(self)   // callback to update ProfileVC
        
    }
}

// MARK: Interactor
extension ProfileVM: ProfileInteractor {
    mutating func getUserData() {
        print("getting user data")
        
        // Get user data form CoreData
        let user = myData.getUser()
        
        // update properties for view model
        profilePic = UIImage(data: (user?.pictureData)!)
        userName = user?.name
        weight = user?.weight
        height = user?.height        
    }
    
}


