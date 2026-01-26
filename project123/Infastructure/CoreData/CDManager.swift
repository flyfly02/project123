//
//  CDManager.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation
import CoreData

class CDManager: PlayerDataSource {
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
    
    func updatePlayer(_ id: String) {
        <#code#>
    }
}
