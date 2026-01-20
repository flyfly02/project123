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

    @NSManaged public var id: UUID!
    @NSManaged public var name: String!
    @NSManaged public var score: Int
    @NSManaged public var roll: Player?

}

extension Player : Identifiable {

}
