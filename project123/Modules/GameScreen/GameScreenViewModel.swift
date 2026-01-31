//
//  GameScreenViewModel.swift
//  project123
//
//  Created by Илья Богуш on 26.01.26.
//

import Foundation

class GameScreenViewModel {
    @Published var players: [PlayerModel] = []
    @Published var currentPlayerIndex: Int = 0
    
    private let fetchAllUseCase: FetchAllPlayersUseCase
    private let updateScoreUseCase: UpdatePlayerScoreUseCase
    
    init(fetchAllPlayerUseCase: FetchAllPlayersUseCase, updateScoreUseCase: UpdatePlayerScoreUseCase ) {
        self.fetchAllUseCase = fetchAllPlayerUseCase
        self.updateScoreUseCase = updateScoreUseCase
    }
    
    func fetchPlayers() {
        players = fetchAllUseCase.execute()
    }
    
    func updateScore(_ player: PlayerModel, _ score: Int)  {
        let updatedPlayer = updateScoreUseCase.execute(player, score)
        if let index = players.firstIndex(where: { $0.id == updatedPlayer.id }) {
                    players[index] = updatedPlayer
        }
    }
}
