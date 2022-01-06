//
//  UserDefaultManager.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import Foundation

class UserDefaultManager {
    
    var store = UserDefaults.standard
    
    func registerUser() {
        store.set(true, forKey: "isRegistered")
    }
    
    func checkIfUserIsRegistered() -> Bool {
        return store.bool(forKey: "isRegistered")
    }
    
    
}
