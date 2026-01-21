//
//  FetchAllPlayersRepo.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

protocol FetchAllPlayersRepo {
    func fetchAllPlayers() -> [PlayerModel]
}
