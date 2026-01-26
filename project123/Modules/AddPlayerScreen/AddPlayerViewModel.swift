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
    private let fetchAllUseCase: FetchAllPlayersUseCase
    
    init(createUseCase: CreatePlayerUseCase, fetchAllUseCase: FetchAllPlayersUseCase) {
        self.createUseCase = createUseCase
        self.fetchAllUseCase = fetchAllUseCase
    }
    
    func createUser() -> PlayerModel? {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("Имя не может быть пустым")
            return nil
        }

        let allPlayers = fetchAllUseCase.execute()
        let isNameTaken = allPlayers.contains { player in
            player.name.lowercased() == name.lowercased()
        }
        
        if isNameTaken {
            print("❌ Игрок с именем '\(name)' уже существует")
            return nil
        }

        print("✅ Создаем игрока: \(name)")
        return createUseCase.execute(name)
    }
}
