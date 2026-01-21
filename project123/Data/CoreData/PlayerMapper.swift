//
//  PlayerMapper.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation
import CoreData

struct PlayerMapper {
    static func toCDModel(_ player: PlayerModel, _ context: NSManagedObjectContext) -> PlayerCDModel {
        let cdPlayer = PlayerCDModel(context: context)
        cdPlayer.id = player.id
        cdPlayer.name = player.name
        cdPlayer.score = player.score
        return cdPlayer
    }
    
    static func toDomainModel(_ player: PlayerCDModel) -> PlayerModel {
        var domainModel = PlayerModel(name: player.name, score: player.score)
        domainModel.id = player.id
        return domainModel
    }
}
