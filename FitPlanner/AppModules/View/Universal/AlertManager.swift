//
//  AlertControllerManager.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/6/22.
//

import Foundation
import UIKit
import UserNotifications

struct AlertManager {
    
    static func showBasicAlert(on vc: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    // Using this as the "This shouldn't happen" alert.
    static func showFillInExercises(on vc: UIViewController){
        showBasicAlert(on: vc, title: "Incomplete form", message: "Make sure all your exercises are filled in before you submit")
    }
    
    
}
