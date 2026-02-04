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
    var playersFirstSymbol: [Character] = []
    @Published var playerFirstSymbolStr: String = ""

    
    private let fetchAllUseCase: FetchAllPlayersUseCase
    private let updateScoreUseCase: UpdatePlayerScoreUseCase
    private let makeRollUseCase: MakeRollUseCase
    
    init(fetchAllPlayerUseCase: FetchAllPlayersUseCase, updateScoreUseCase: UpdatePlayerScoreUseCase, makeRollUseCase: MakeRollUseCase ) {
        self.fetchAllUseCase = fetchAllPlayerUseCase
        self.updateScoreUseCase = updateScoreUseCase
        self.makeRollUseCase = makeRollUseCase
    }
    
    func fetchPlayers() {
        players = fetchAllUseCase.execute()
        getFirstSymbolPlayer()
    }
    
    func makeRoll(_ value: Int) {
        let currentPlayer = players[currentPlayerIndex]

            
            // 2. Создаем бросок (UseCase должен обновлять счет в БД)
            makeRollUseCase.execute(currentPlayer, value)
            
            // 3. ОБНОВЛЯЕМ локальный массив players!
            let newScore = currentPlayer.score + value
            updateScore(currentPlayer, newScore) // ← Это обновит players[index]
            
            // 4. Обновляем строку с символами
            getFirstSymbolPlayer()
    }
    
    func updateScore(_ player: PlayerModel, _ score: Int)  {
        let updatedPlayer = updateScoreUseCase.execute(player, score)
        if let index = players.firstIndex(where: { $0.id == updatedPlayer.id }) {
                    players[index] = updatedPlayer
        }
    }
    
    func getFirstSymbolPlayer() {
        let players = players.compactMap {$0.name.first}
            .map{String($0)}
            .joined(separator: " ")
        playerFirstSymbolStr = players
    }
}
