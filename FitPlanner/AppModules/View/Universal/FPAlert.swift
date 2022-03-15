//
//  FPAlert.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/15/22.
//

import Foundation
import UIKit
import UserNotifications

struct FPAlert {
    
    static func showUpdateWeightAlert(on vc: UIViewController, pickerView: UIPickerView, pickerData: [Int], weight: Double, confirmAlertAction: @escaping (() -> ())) {
        let ac = UIAlertController(title: "Your new weight (lbs)", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(pickerView)
        pickerView.selectRow(Int(weight) - 1, inComponent: 0, animated: false)

        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            confirmAlertAction()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(ac, animated: true)
        }
    }
    
}

