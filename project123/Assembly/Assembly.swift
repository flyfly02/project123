//
//  Assembly.swift
//  project123
//
//  Created by Илья Богуш on 21.01.26.
//

import Foundation

class Assembly {
    static let shared = Assembly()
    private init() {}
    
    private lazy var persistentController: PersistentController = {
            return PersistentController()
        }()
    
     func createStartVcViewModel() -> StartVcViewModel {
        let datasourceImpl = CDManager(persistentController.persistentContainer.viewContext)
        let fetchAllPlayersRepo = PlayerRepoImpl(dataSource: datasourceImpl)
        let fetchAllPlayersUseCase = FetchAllPlayersUseCaseImpl(repo: fetchAllPlayersRepo)
        let deletePlayerUseCase = DeletePlayerUseCaseImpl(repo: fetchAllPlayersRepo)
        return StartVcViewModel(fetchAllUseCase: fetchAllPlayersUseCase, deleteUseCase: deletePlayerUseCase)
    }
    
     func createAddPlayerViewModel() -> AddPlayerViewModel {
        let datasourceImpl = CDManager(persistentController.persistentContainer.viewContext)
        let fetchAllPlayersRepo = PlayerRepoImpl(dataSource: datasourceImpl)
        let fetchAllPlayersUseCase = FetchAllPlayersUseCaseImpl(repo: fetchAllPlayersRepo)
        let createUseCase = CreatePlayerUseCaseImpl(repo: fetchAllPlayersRepo)
        return AddPlayerViewModel(createUseCase: createUseCase, fetchAllUseCase: fetchAllPlayersUseCase)
    }
    
    func createGameScreenViewModel() -> GameScreenViewModel {
        let datasourceImpl = CDManager(persistentController.persistentContainer.viewContext)
        let fetchAllPlayersRepo = PlayerRepoImpl(dataSource: datasourceImpl)
        let fetchAllPlayersUseCase = FetchAllPlayersUseCaseImpl(repo: fetchAllPlayersRepo)
        let updatePlayerScoreUseCase = UpdatePlayerScoreUseCaseImpl(repo: fetchAllPlayersRepo)
        return GameScreenViewModel(fetchAllPlayerUseCase: fetchAllPlayersUseCase, updateScoreUseCase: updatePlayerScoreUseCase)
    }
}
