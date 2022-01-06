//
//  ProfileVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import UIKit

// MARK: Protocols
protocol ProfileInteractor {
    func getUserData()
}

protocol ProfilePresentor {
    func updateProfile()
}


// MARK: View Model
struct ProfileVM {
    var profilePic: UIImage?
    var userName: String?
    var weight: Double?
    var height: Double?
    
    init() {
        
    }
}


// MARK: Interactor
extension ProfileVM: ProfileInteractor {
    func getUserData() {
        print("getting user data")
        // Get user data form CoreData & File Manager
        // update properties for view model
        // pass it to Presentor
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
