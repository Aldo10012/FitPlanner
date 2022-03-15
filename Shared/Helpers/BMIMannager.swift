//
//  BMIMannager.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/15/22.
//

import Foundation

class BMIMannager {
    
    /// Returns the BMI based on a given height (inches) and weight (lbs)
    static func calculateBMI(height inches: Double, weight lbs: Double) -> Double {
        // BMI = kg/m^2
        // kg = 2.20462 lb
        // m = 39.3701 in
        
        let kg = 2.20462 * lbs
        let m = 39.3701 * inches
        let bmi = kg / pow(m, 2)
        return bmi
    }
    
    static func getBMIScaleDescription(bmi: Double) -> String {
        if bmi < 30 {
            return "You are obese"
        }
        else if bmi < 25 {
            return "You are over weight"
        }
        else if bmi < 18.5 {
            return "You are healthy"
        }
        else {
            return "You are under weight"
        }
    }
}
