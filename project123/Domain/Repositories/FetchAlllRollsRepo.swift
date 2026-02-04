//
//  FetchAlllRollsRepo.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation

protocol FetchAllRollsRepo {
    func fetchRolls() -> [RollModel]
}
