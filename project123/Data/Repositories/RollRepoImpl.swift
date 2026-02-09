//
//  RollRepoImpl.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

final class RollRepoImpl: FetchAllRollsRepo, MakeRollRepo, CancelRollRepo {
    
    private let dataSource: RollDataSource
    init(dataSource: RollDataSource) {
        self.dataSource = dataSource
    }
    func fetchRolls() -> [RollModel] {
        dataSource.fetchRolls()
    }
    
    func makeRoll(roll: RollModel) -> RollModel {
        dataSource.makeRoll(roll: roll)
    }
    
    func cancelRoll(playerId: String, oldScore: Int, rollValue: Int) -> Bool {
        dataSource.deleteLastRollForPlayer(playerId: playerId, rollValue: rollValue)
    }
}
