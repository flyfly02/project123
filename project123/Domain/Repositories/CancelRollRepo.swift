//
//  CancelRollRepo.swift
//  project123
//
//  Created by Илья Богуш on 9.02.26.
//

import Foundation

protocol CancelRollRepo {
    func cancelRoll(playerId: String, oldScore: Int, rollValue: Int) -> Bool
}

