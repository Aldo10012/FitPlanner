//
//  GetStartedVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import UIKit

// MARK: Protocols
protocol GetStartedInteractor {
    func registerUser()
}


// MARK: View Model
struct GetStartedVM {
    let myData = CoreDataStack.shared
    
    var pictureData: Data?
    var pictureIsSelected: Bool?
    var userName: String?
    var height: Double?
    var weight: Double?
    
    var formIsValid: Bool {
        guard let heightx = height else { return false }
        guard let weightx = weight else { return false }
        
        return pictureIsSelected == true &&
               userName?.isEmpty == false &&
               heightx > 0 &&
               weightx > 0
    }
}


// MARK: Interactor
extension GetStartedVM: GetStartedInteractor {
    func registerUser() {
        print("register user")
        // get data from view model
        // pass them to CoreDataStack to create user
        
        myData.registerNewUser(
            userName: userName!,
            height: height!,
            weight: weight!,
            pictureData: pictureData!
        )
        
        let bmi = BMIMannager.calculateBMI(height: height!, weight: weight!)
        myData.userDidLogBMI(date: Date(), weight: weight!, bmi: bmi)
    }
}
