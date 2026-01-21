//
//  PersistentContainer.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation
import CoreData

final class PersistentController {
    lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreDataModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()
}
