//
//  AddPlayerViewModel.swift
//  project123
//
//  Created by Илья Богуш on 22.01.26.
//

import Foundation
import UIKit
import Combine

class AddPlayerViewModel {

    @Published var name: String = ""
    private let createUseCase: CreatePlayerUseCase
    
    init(createUseCase: CreatePlayerUseCase){
        self.createUseCase = createUseCase
    }
    
    func createUser() {
        createUseCase.execute(PlayerModel(name: name, score: 0))
    }
}
