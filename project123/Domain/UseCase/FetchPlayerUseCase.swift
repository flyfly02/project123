//
//  FetchPlayerUseCase.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

protocol FetchPlayerUseCase {
    func execute(_ id: String) -> PlayerModel
}

final class FetchPlayerUseCaseImpl: FetchPlayerUseCase {
    private let repo: FetchPlayerRepo
    init(repo: FetchPlayerRepo) {
        self.repo = repo
    }
    func execute(_ id: String) -> PlayerModel {
        repo.fetchPlayer(id)
    }
}
