//
//  Roll+CoreDataProperties.swift
//  project123
//
//  Created by Илья Богуш on 10.01.26.
//
//

import Foundation
import CoreData


extension RollCdModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RollCdModel> {
        return NSFetchRequest<RollCdModel>(entityName: "RollCdModel")
    }

    @NSManaged public var id: String!
    @NSManaged public var value: Int
    @NSManaged public var player: PlayerCDModel?

}

extension RollCdModel : Identifiable {

}
