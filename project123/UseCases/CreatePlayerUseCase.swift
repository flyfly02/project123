//
//  CreatePlayerUseCase.swift
//  project123
//
//  Created by Илья Богуш on 20.01.26.
//

import Foundation

protocol PlayerUseCase {
    func createExecute(_ player: Player) -> Player
    func fetchExecute(_ id: UUID) -> Player
    func fetchAllxecute() -> [Player]
    func deleteExecute(_ id:UUID)

}

final class PlayerUseCaseImpl: PlayerUseCase {
    private let repository: PlayerRepositoryProtocol
    init(_ repo: PlayerRepositoryProtocol) {
        self.repository = repo
    }
    
    func createExecute(_ player: Player) -> Player {
        repository.createPlayer(player)
    }
    
    func fetchExecute(_ id: UUID) -> Player {
        repository.fetchPlayer(id)
    }
    
    func fetchAllxecute() -> [Player] {
        repository.fetchAllPlayers()
    }
    
    func deleteExecute(_ id: UUID) {
        repository.deletePlayer(id)
    }
 
}



