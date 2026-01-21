//
//  Player+CoreDataProperties.swift
//  project123
//
//  Created by Илья Богуш on 10.01.26.
//
//

import Foundation
import CoreData


extension PlayerCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerCDModel> {
        return NSFetchRequest<PlayerCDModel>(entityName: "PlayerCDModel")
    }

    @NSManaged public var id: String!
    @NSManaged public var name: String!
    @NSManaged public var score: Int
    @NSManaged public var roll: PlayerCDModel?

}

extension PlayerCDModel : Identifiable {

}
