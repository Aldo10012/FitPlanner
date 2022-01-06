//
//  ProfileVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import UIKit
import CoreData

// MARK: Protocols
protocol ProfileInteractor {
    mutating func getUserData()
}

protocol ProfilePresentor {
    func updateProfile()
}


// MARK: View Model
struct ProfileVM {
    fileprivate let myData = CoreDataStack()
//    fileprivate var user: User?
    
    var profilePic: UIImage?
    var userName: String?
    var weight: Double?
    var height: Double?
    
    init() {
        
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
        
        updateProfile()
    }
    
}

// MARK: Presentor
extension ProfileVM: ProfilePresentor {
    func updateProfile() {
        print("update views on PrifileVC")
        // update viewController views
        
    }
    
    
}
