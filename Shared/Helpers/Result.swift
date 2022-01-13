//
//  Result.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/9/22.
//

import Foundation

enum Result<Success, Fail> {
    case success(Success)
    case failure(Fail)
}
