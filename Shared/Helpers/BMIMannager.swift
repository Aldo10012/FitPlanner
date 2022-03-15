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
        // BMI = (weight in pounds x 703) / (height in inches x height in inches).
        return (lbs * 703) / (pow(inches, 2))
        
    }
    
    static func getBMIScaleDescription(bmi: Double) -> String {
        if bmi > 30 {
            return "You are obese"
        }
        else if bmi > 25 {
            return "You are over weight"
        }
        else if bmi > 18.5 {
            return "You are healthy"
        }
        else {
            return "You are under weight"
        }
    }
}
