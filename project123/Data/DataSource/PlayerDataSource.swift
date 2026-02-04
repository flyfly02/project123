//
//  PlayerDataSource.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

protocol PlayerDataSource {
    func createPlayer(_ player: PlayerModel) -> PlayerModel
    func fetchPlayer(_ id: String) -> PlayerModel
    func fetchAllPlayers() -> [PlayerModel]
    func deletePlayer(_ id:String)
    func updatePlayer(_ player: PlayerModel) -> PlayerModel
    
}
