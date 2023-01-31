//
//  PersistentController.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import CoreData

struct PersistentController {
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Paperoad")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
