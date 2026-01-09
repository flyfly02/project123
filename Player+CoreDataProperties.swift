//
//  Player+CoreDataProperties.swift
//  project123
//
//  Created by Илья Богуш on 9.01.26.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var totalScore: Int64
    @NSManaged public var throws: NSSet?

}

// MARK: Generated accessors for throws
extension Player {

    @objc(addThrowsObject:)
    @NSManaged public func addToThrows(_ value: Roll)

    @objc(removeThrowsObject:)
    @NSManaged public func removeFromThrows(_ value: Roll)

    @objc(addThrows:)
    @NSManaged public func addToThrows(_ values: NSSet)

    @objc(removeThrows:)
    @NSManaged public func removeFromThrows(_ values: NSSet)

}

extension Player : Identifiable {

}
