//
//  CancelRollUseCase.swift
//  project123
//
//  Created by Илья Богуш on 9.02.26.
//

import Foundation

protocol CancelRollUseCase {
    func execute(_ playerId: String, oldScore: Int, rollValue: Int) -> Bool
}

final class CancelRollUseCaseImpl: CancelRollUseCase {
    private let repo: CancelRollRepo
    
    init(repo: CancelRollRepo) {
        self.repo = repo
    }
    
    func execute(_ playerId: String, oldScore: Int, rollValue: Int) -> Bool {
        return repo.cancelRoll(playerId: playerId, oldScore: oldScore, rollValue: rollValue)
    }
}
