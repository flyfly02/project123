//
//  GameScreenViewModel.swift
//  project123
//
//  Created by Илья Богуш on 26.01.26.
//

import Foundation

class GameScreenViewModel {
    @Published var players: [PlayerModel] = []
    private var fetchAllUseCase: FetchAllPlayersUseCase
    
    init(fetchAllPlayerUseCase: FetchAllPlayersUseCase) {
        self.fetchAllUseCase = fetchAllPlayerUseCase
    }
    
    func fetchPlayers() {
        players = fetchAllUseCase.execute()
    }
}
