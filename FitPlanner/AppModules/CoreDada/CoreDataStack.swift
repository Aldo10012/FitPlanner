//
//  CoreDataStack.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import CoreData
import Foundation
import UIKit

// inspired by https://codereview.stackexchange.com/questions/220783/core-data-wrapper

struct CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
