//
//  CreatePlayerUseCase.swift
//  project123
//
//  Created by Илья Богуш on 20.01.26.
//

import Foundation

protocol CreatePlayerUseCase {
    func execute(_ name: String) -> PlayerModel
}

final class CreatePlayerUseCaseImpl: CreatePlayerUseCase {
    private let repo: CreatePlayerRepo
    init(repo: CreatePlayerRepo) {
        self.repo = repo
    }
    func execute(_ name: String) -> PlayerModel {
        let player = repo.createPlayer(PlayerModel(name: name, score: 0))

        return player
    }
}





