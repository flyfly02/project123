//
//  CancelRollRepo.swift
//  project123
//
//  Created by Илья Богуш on 9.02.26.
//

import Foundation

final class CancelRollRepoImpl: CancelRollRepo {
    private let playerDataSource: PlayerDataSource
    private let rollDataSource: RollDataSource
    
    init(playerDataSource: PlayerDataSource, rollDataSource: RollDataSource) {
        self.playerDataSource = playerDataSource
        self.rollDataSource = rollDataSource
    }
    
    func cancelRoll(playerId: String, oldScore: Int, rollValue: Int) -> Bool {
        print("🎲 CancelRollRepo: playerId=\(playerId), oldScore=\(oldScore), rollValue=\(rollValue)")
        var player = playerDataSource.fetchPlayer(playerId)
        
        if player.name == "cantFindUser" {
            print("❌ Игрок не найден")
            return false
        }
        
        player.score = oldScore
        _ = playerDataSource.updatePlayer(player)
        return deleteLastRollForPlayer(playerId: playerId, rollValue: rollValue)
    }
    
    private func deleteLastRollForPlayer(playerId: String, rollValue: Int) -> Bool {

        if let cdManager = playerDataSource as? CDManager {
            return cdManager.deleteLastRollForPlayer(playerId: playerId, rollValue: rollValue)
        }
        
        return false
    }
}
