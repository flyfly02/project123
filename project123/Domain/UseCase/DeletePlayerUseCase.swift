//
//  DeletePlayerUseCase.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

protocol DeletePlayerUseCase {
    func execute(_ id:String)
}

final class DeletePlayerUseCaseImpl: DeletePlayerUseCase {
    private let repo: DeletePlayerRepo
    init(repo: DeletePlayerRepo) {
        self.repo = repo
    }
    func execute(_ id: String) {
        repo.deletePlayer(id)
    }
}
