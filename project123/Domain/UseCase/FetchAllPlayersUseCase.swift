//
//  FetchAllPlayersUseCase.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

protocol FetchAllPlayersUseCase {
    func execute() -> [PlayerModel]
}

final class FetchAllPlayersUseCaseImpl: FetchAllPlayersUseCase {
    private let repo: FetchAllPlayersRepo
    init(repo: FetchAllPlayersRepo) {
        self.repo = repo
    }
    func execute() -> [PlayerModel] {
        repo.fetchAllPlayers()
    }
    
}
