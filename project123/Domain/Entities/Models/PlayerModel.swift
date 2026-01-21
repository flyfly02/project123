//
//  PlayerModel.swift
//  project123
//
//  Created by Илья Богуш on 20.01.26.
//

import Foundation

struct PlayerModel: Equatable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var score: Int
}
