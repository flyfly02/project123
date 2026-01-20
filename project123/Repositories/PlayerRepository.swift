//
//  PlayerRepositoryProtocol.swift
//  project123
//
//  Created by Илья Богуш on 20.01.26.
//

import Foundation

protocol PlayerRepositoryProtocol {
    func createPlayer(_ player: Player) -> Player
    func fetchPlayer(_ id: UUID) -> Player
    func fetchAllPlayers() -> [Player]
    func deletePlayer(_ id:UUID)
}

