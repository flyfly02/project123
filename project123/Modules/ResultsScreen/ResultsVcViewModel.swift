//
//  ResultsVcViewModel.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation
import Combine

class ResultsVcViewModel{
    @Published var players: [PlayerModel] = []
    @Published var rolls: [RollModel] = []
    
    private let fetchAllPlayersUseCase: FetchAllPlayersUseCase
    private let fetchAllRollsUSeCase: FetchAllRollsUseCase

    init(fetchAllPlayerUseCase: FetchAllPlayersUseCase, fetchAllRollsUSeCase: FetchAllRollsUseCase ) {
        self.fetchAllPlayersUseCase = fetchAllPlayerUseCase
        self.fetchAllRollsUSeCase = fetchAllRollsUSeCase
    }
    
    func fetchAllPlayers() {
        players = fetchAllPlayersUseCase.execute().sorted{$0.score > $1.score}
    }
    
    func fetchAllRolls() {
        rolls = fetchAllRollsUSeCase.execute()
    }
    
    
}
