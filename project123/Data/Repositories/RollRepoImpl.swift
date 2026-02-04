//
//  RollRepoImpl.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

final class RollRepoImpl: FetchAllRollsRepo, MakeRollRepo {
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
}
