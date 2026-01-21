//
//  RollModel.swift
//  project123
//
//  Created by Илья Богуш on 20.01.26.
//

import Foundation

struct RollModel: Equatable, Hashable {
    let id: String = UUID().uuidString
    let value: Int
}
