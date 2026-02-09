//
//  RollDataSource.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

protocol RollDataSource {
    func fetchRolls() -> [RollModel]
    func makeRoll(roll: RollModel) -> RollModel
    func deleteLastRollForPlayer(playerId: String, rollValue: Int) -> Bool
}
