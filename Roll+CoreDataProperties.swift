//
//  Roll+CoreDataProperties.swift
//  project123
//
//  Created by Илья Богуш on 9.01.26.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var value: Int64
    @NSManaged public var player: Player?

}

extension Roll : Identifiable {

}
