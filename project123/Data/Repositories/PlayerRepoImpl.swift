//
//  PlayerRepoImpl.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

final class PlayerRepoImpl:CreatePlayerRepo, FetchPlayerRepo, FetchAllPlayersRepo, DeletePlayerRepo, UpdatePlayerRepo {
    private let dataSource: PlayerDataSource
    init(dataSource: PlayerDataSource) {
        self.dataSource = dataSource
    }
    func createPlayer(_ player: PlayerModel) -> PlayerModel {
        dataSource.createPlayer(player)
    }
    
    func fetchPlayer(_ id: String) -> PlayerModel {
        dataSource.fetchPlayer(id)
    }
    
    func fetchAllPlayers() -> [PlayerModel] {
        dataSource.fetchAllPlayers()
    }
    
    func deletePlayer(_ id: String) {
        dataSource.deletePlayer(id)
    }
    
    func UpdatePlayerRepo(_ id: String) {
        dataSource.updatePlayer(id)
    }
    
}
