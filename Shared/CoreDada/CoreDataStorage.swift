//
//  CoreDataStorage.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/10/23.
//

import Foundation
import CoreData

class CoreDataStorage {
    static let shared = CoreDataStorage()
    
    private let persistentContainer: PersistentContainer
    public var managedContext: NSManagedObjectContext
    
    init(persistentContainer: PersistentContainer = PersistentContainer.build()) {
        self.persistentContainer = persistentContainer
        self.managedContext = persistentContainer.viewContext
    }
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // TODO: - Log to Crashlytics
                assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
