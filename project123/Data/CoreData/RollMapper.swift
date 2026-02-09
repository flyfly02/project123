//
//  RollMapper.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation
import CoreData

struct RollMapper {
    static func toCDModel(_ roll: RollModel,
                         _ context: NSManagedObjectContext,
                         player: PlayerCDModel? = nil) -> RollCdModel {
        let cdRoll = RollCdModel(context: context)
        cdRoll.id = roll.id
        cdRoll.value = roll.value
        cdRoll.player = player
        if let player = player {
                    cdRoll.player = player  
                }
        
        return cdRoll
    }

    static func toDomainModel(_ cdRoll: RollCdModel) -> RollModel {
        let playerName = cdRoll.player?.name ?? "Unknown"
        return RollModel(
            value: cdRoll.value,
            playerName: playerName
        )
    }
}
