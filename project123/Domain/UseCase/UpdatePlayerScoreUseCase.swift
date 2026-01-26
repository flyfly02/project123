//
//  UpdatePlayerScore.swift
//  project123
//
//  Created by Илья Богуш on 26.01.26.
//

import Foundation

protocol UpdatePlayerScoreUseCase {
    func execute(_ player: PlayerModel, _ score: Int) -> PlayerModel
}

final class UpdatePlayerScoreUseCaseImpl: UpdatePlayerScoreUseCase {
    let repo: FetchPlayerRepo
    init(repo: FetchPlayerRepo) {
        self.repo = repo
    }
    
    
    func execute(_ player: PlayerModel, _ score: Int) -> PlayerModel {
        var player = repo.fetchPlayer(player.id)
        player.score = score
        return player
    }
}

