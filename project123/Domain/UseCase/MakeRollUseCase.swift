//
//  MakeRollUseCase.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

protocol MakeRollUseCase {
    func execute(_ player: PlayerModel, _ value: Int) -> RollModel
}

final class MakeRollUseCaseImpl: MakeRollUseCase {
    private let fetchRepo: MakeRollRepo
    private let updatePlayer: UpdatePlayerRepo
    init(fetchRepo: MakeRollRepo, updatePalyerRepo: UpdatePlayerRepo) {
        self.fetchRepo = fetchRepo
        self.updatePlayer = updatePalyerRepo
    }
    
    func execute(_ player: PlayerModel, _ value: Int) -> RollModel {
        // Сохраняем оригинальное имя
        let originalName = player.name
        
        var updatedPlayer = player
        updatedPlayer.score += value
        updatePlayer.UpdatePlayerRepo(updatedPlayer)
        
        // Используем ОРИГИНАЛЬНОЕ имя для поиска
        let roll = RollModel(value: value, playerName: originalName)
        return fetchRepo.makeRoll(roll: roll)
    }
    
}


