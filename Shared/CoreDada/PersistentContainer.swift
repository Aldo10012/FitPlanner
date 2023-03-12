//
//  PersistentContainer.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/10/23.
//

import CoreData
import Foundation

// https://medium.com/@manibatra23/sharing-data-using-core-data-ios-app-and-extension-fb0a176eaee9

class PersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Alberto-Dominguez.FitPlanner")
        storeURL = storeURL?.appendingPathComponent("FitPlanner.sqlite")
        return storeURL!
    }
    
    static func build() -> PersistentContainer {
        let container = PersistentContainer()
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
}
