//
//  Player+CoreDataProperties.swift
//  project123
//
//  Created by Илья Богуш on 10.01.26.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var id: NSObject?
    @NSManaged public var name: NSObject?
    @NSManaged public var score: NSObject?
    @NSManaged public var roll: Roll?

}

extension Player : Identifiable {

}
