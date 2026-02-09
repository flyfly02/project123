//
//  FetchAllRollsUseCase.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

protocol FetchAllRollsUseCase {
    func execute() -> [RollModel]
}

final class FetchAllRollsUseCaseImpl: FetchAllRollsUseCase {
    let fetchRepo: FetchAllRollsRepo
    init(_ repo: FetchAllRollsRepo) {
        self.fetchRepo = repo
    }
    
    func execute() -> [RollModel] {
        fetchRepo.fetchRolls()
    }
}
