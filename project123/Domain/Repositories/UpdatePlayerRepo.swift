//
//  UpdatePlayerRepo.swift
//  project123
//
//  Created by Илья Богуш on 26.01.26.
//

import Foundation

protocol UpdatePlayerRepo {
    @discardableResult
    func UpdatePlayerRepo(_ player: PlayerModel) -> PlayerModel
}
