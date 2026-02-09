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
    @Published var playerFirstSymbolStr: String = ""
    
    // Храним playerName и rollValue, oldScore будем вычислять
    private var rollHistory: [(playerName: String, rollValue: Int)] = []
    
    private let fetchAllUseCase: FetchAllPlayersUseCase
    private let updateScoreUseCase: UpdatePlayerScoreUseCase
    private let makeRollUseCase: MakeRollUseCase
    private let cancelRollUseCase: CancelRollUseCase // Принимает (playerId, oldScore, rollValue)
    private let fetchRollsUseCase: FetchAllRollsUseCase
    
    var canUndo: Bool {
        return !rollHistory.isEmpty
    }
    
    init(fetchAllPlayerUseCase: FetchAllPlayersUseCase,
         updateScoreUseCase: UpdatePlayerScoreUseCase,
         makeRollUseCase: MakeRollUseCase,
         cancelRollUseCase: CancelRollUseCase,
         fetchRollsUseCase: FetchAllRollsUseCase) {
        self.fetchAllUseCase = fetchAllPlayerUseCase
        self.updateScoreUseCase = updateScoreUseCase
        self.makeRollUseCase = makeRollUseCase
        self.cancelRollUseCase = cancelRollUseCase
        self.fetchRollsUseCase = fetchRollsUseCase
    }
    
    func fetchPlayers() {
        players = fetchAllUseCase.execute()
        getFirstSymbolPlayer()
        loadRollHistoryFromDatabase()
    }
    
    private func loadRollHistoryFromDatabase() {
        let allRolls = fetchRollsUseCase.execute()
        // Преобразуем RollModel в историю
        rollHistory = allRolls.map { ($0.playerName, $0.value) }
    }
    
    func makeRoll(_ value: Int) {
        let currentPlayer = players[currentPlayerIndex]
        
        // Сохраняем в историю
        rollHistory.append((currentPlayer.name, value))
        
        // Создаем бросок в БД
        makeRollUseCase.execute(currentPlayer, value)
        
        // Обновляем счет
        let newScore = currentPlayer.score + value
        updateScore(currentPlayer, newScore)
        
        // Обновляем UI
        getFirstSymbolPlayer()
    }
    
    func updateScore(_ player: PlayerModel, _ score: Int) {
        let updatedPlayer = updateScoreUseCase.execute(player, score)
        if let index = players.firstIndex(where: { $0.id == updatedPlayer.id }) {
            players[index] = updatedPlayer
        }
    }
    
    func undoLastRoll() -> Bool {
        guard let lastRoll = rollHistory.last else {
            return false
        }
        guard let player = players.first(where: { $0.name == lastRoll.playerName }) else {

            return false
        }

        let oldScore = player.score - lastRoll.rollValue
        let success = cancelRollUseCase.execute(
            player.id,
            oldScore: oldScore,
            rollValue: lastRoll.rollValue
        )
        
        if success {
            updateScore(player, oldScore)
            rollHistory.removeLast()
            getFirstSymbolPlayer()
            return true
        }
        
        return false
    }
    
    func getFirstSymbolPlayer() {
        let symbols = players.compactMap { $0.name.first }
            .map { String($0) }
            .joined(separator: " ")
        playerFirstSymbolStr = symbols
    }
}
