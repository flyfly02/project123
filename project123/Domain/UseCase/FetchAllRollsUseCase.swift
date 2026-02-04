//
//  FetchAllRollsUseCase.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

protocol FechAllRollsUseCase {
    func execute() -> [RollModel]
}

final class FetchAllRollsUseCaseImpl: FechAllRollsUseCase {
    let fetchRepo: FetchAllRollsRepo
    init(_ repo: FetchAllRollsRepo) {
        self.fetchRepo = repo
    }
    
    func execute() -> [RollModel] {
        fetchRepo.fetchRolls()
    }
}
