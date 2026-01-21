//
//  CreatePlayerUseCase.swift
//  project123
//
//  Created by Илья Богуш on 20.01.26.
//

import Foundation

protocol CreatePlayerUseCase {
    func execute(_ player: PlayerModel)
}

final class CreatePlayerUseCaseImpl: CreatePlayerUseCase {
    private let repo: CreatePlayerRepo
    init(repo: CreatePlayerRepo) {
        self.repo = repo
    }
    func execute(_ player: PlayerModel) {
        repo.createPlayer(player)
    }
}





