//
//  StartVcViewModel.swift
//  project123
//
//  Created by Илья Богуш on 22.01.26.
//

import Foundation
import UIKit
import Combine

class StartVcViewModel {
    @Published var players: [PlayerModel] = []
    
    var onAddButtonTapped: (() -> Void)?
    
    private let fetchAllUseCase: FetchAllPlayersUseCase
    private let deleteUseCase: DeletePlayerUseCase
    
    init(fetchAllUseCase: FetchAllPlayersUseCase, deleteUseCase: DeletePlayerUseCase) {
        self.fetchAllUseCase = fetchAllUseCase
        self.deleteUseCase  = deleteUseCase
    }
    
    func fetchPlayer() {
        players = fetchAllUseCase.execute()
    }
    
    func deletePlayer(_ id: String) {
        deleteUseCase.execute(id)
        fetchPlayer()
    }
    
}
