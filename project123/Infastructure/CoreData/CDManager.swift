//
//  CDManager.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation
import CoreData

class CDManager: PlayerDataSource, RollDataSource {
    let context: NSManagedObjectContext
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    func createPlayer(_ player: PlayerModel)-> PlayerModel {
        _ = PlayerMapper.toCDModel(player, context)
        try? context.save()
        return player
 
    }
    
    func fetchPlayer(_ id: String) -> PlayerModel {
        let request = PlayerCDModel.fetchRequest()
        if let players = try? context.fetch(request), let player = players.first(where: {$0.id == id}) {
            return PlayerMapper.toDomainModel(player)
        }
        return PlayerModel(name: "cantFindUser", score: 404)
    }
    
    func fetchAllPlayers() -> [PlayerModel] {
        let request = PlayerCDModel.fetchRequest()
        if let players = try? context.fetch(request) {
            let playersDomain = players.map {
                PlayerMapper.toDomainModel($0)
            }
            return playersDomain
        }
        return []
    }
    
    func deletePlayer(_ id: String) {
        let request = PlayerCDModel.fetchRequest()
        if let players = try? context.fetch(request), let player = players.first(where: {$0.id == id}) {
            context.delete(player)
            try? context.save()
        }
    }
    
    func updatePlayer(_ player: PlayerModel) -> PlayerModel {
        let request = PlayerCDModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", player.id)
        let results = try? context.fetch(request)
            
        if let playerEntity = results?.first {
            playerEntity.name = player.name
            playerEntity.score = player.score
            try? context.save()
                return PlayerMapper.toDomainModel(playerEntity)
            }
        return player
    }
    
    func fetchRolls() -> [RollModel] {
        
        let request = RollCdModel.fetchRequest()
        request.relationshipKeyPathsForPrefetching = ["player"]
        request.returnsObjectsAsFaults = false
    
        do {
            let cdRolls = try context.fetch(request)
            print(cdRolls)
            return cdRolls.map { cdRoll in
                RollMapper.toDomainModel(cdRoll)
            }
        } catch {
            print("Error fetching rolls: \(error)")
            return []
        }
    }
        
    func makeRoll(roll: RollModel) -> RollModel {

        let playerRequest = PlayerCDModel.fetchRequest()
        playerRequest.predicate = NSPredicate(format: "name == %@", roll.playerName)
        
        var cdPlayer: PlayerCDModel?
        
        if let players = try? context.fetch(playerRequest),
           let player = players.first {
            cdPlayer = player
        }
        _ = RollMapper.toCDModel(roll, context, player: cdPlayer)
        try? context.save()
        return roll
    }
    
}
