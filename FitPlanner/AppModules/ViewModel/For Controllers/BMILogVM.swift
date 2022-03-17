//
//  BMILogVM.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/17/22.
//

import Foundation

// MARK: Protocols
protocol BMILogInteractor {
    func getBMIHistory() -> [BMILog]
}

protocol BMILogPresentor {
    mutating func onViewDidLoad()
}

// MARK: ViewModel
struct BMILogVM {
    var history: [BMILog]?
}


// MARK: Presentor
extension BMILogVM: BMILogPresentor {
    mutating func onViewDidLoad() {
        
        
        
        return
    }
    
    
}

// MARK: Interactor
extension BMILogVM: BMILogInteractor {
    func getBMIHistory() -> [BMILog] {
        
        
        
        return []
    }
}
