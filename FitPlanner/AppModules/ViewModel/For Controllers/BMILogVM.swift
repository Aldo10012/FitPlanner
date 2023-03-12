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
    mutating func onViewDidLoad(success: @escaping () -> ())
}

// MARK: ViewModel
struct BMILogVM {
    let userBMIStorage = UserBMICoreDataStorage()
    var history: [BMILog] = []
}


// MARK: Presentor
extension BMILogVM: BMILogPresentor {
    mutating func onViewDidLoad(success: @escaping () -> ()) {
        let bmiHistory = getBMIHistory()
        history = bmiHistory.reversed()
    }
}

// MARK: Interactor
extension BMILogVM: BMILogInteractor {
    func getBMIHistory() -> [BMILog] {
        print("BMI History:", userBMIStorage.getMBILog())
        return userBMIStorage.getMBILog()
    }
}
