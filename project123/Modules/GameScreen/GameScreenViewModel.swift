//
//  GameScreenViewModel.swift
//  project123
//
//  Created by Илья Богуш on 26.01.26.
//

import Foundation

class GameScreenViewModel {
    @Published var players: [PlayerModel] = []
    private let fetchAllUseCase: FetchAllPlayersUseCase
    private let updateScoreUseCase: UpdatePlayerScoreUseCase
    
    init(fetchAllPlayerUseCase: FetchAllPlayersUseCase, updateScoreUseCase: UpdatePlayerScoreUseCase ) {
        self.fetchAllUseCase = fetchAllPlayerUseCase
        self.updateScoreUseCase = updateScoreUseCase
    }
    
    func fetchPlayers() {
        players = fetchAllUseCase.execute()
    }
}
