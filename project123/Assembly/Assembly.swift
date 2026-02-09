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
        let makeRollRepo = RollRepoImpl(dataSource: datasourceImpl)
        let fetchAllPlayersUseCase = FetchAllPlayersUseCaseImpl(repo: fetchAllPlayersRepo)
        let updatePlayerScoreUseCase = UpdatePlayerScoreUseCaseImpl(repo: fetchAllPlayersRepo)
        let makeRollUseCase = MakeRollUseCaseImpl(fetchRepo: makeRollRepo, updatePalyerRepo: fetchAllPlayersRepo)
        let cancelRollUseCase = CancelRollUseCaseImpl(repo: makeRollRepo)
        let fetchAllRollsUseCase = FetchAllRollsUseCaseImpl(makeRollRepo)
        return GameScreenViewModel(fetchAllPlayerUseCase: fetchAllPlayersUseCase, updateScoreUseCase: updatePlayerScoreUseCase, makeRollUseCase: makeRollUseCase, cancelRollUseCase: cancelRollUseCase, fetchRollsUseCase: fetchAllRollsUseCase)
    }
    
    func createResultsVcViewModel() -> ResultsVcViewModel {
       let datasourceImpl = CDManager(persistentController.persistentContainer.viewContext)
       let fetchAllPlayersRepo = PlayerRepoImpl(dataSource: datasourceImpl)
        let fetchAllRollsRepo = RollRepoImpl(dataSource: datasourceImpl)
       let fetchAllPlayersUseCase = FetchAllPlayersUseCaseImpl(repo: fetchAllPlayersRepo)
       let fetchAllRollsUseCase = FetchAllRollsUseCaseImpl(fetchAllRollsRepo)
        return ResultsVcViewModel(fetchAllPlayerUseCase: fetchAllPlayersUseCase, fetchAllRollsUSeCase: fetchAllRollsUseCase)
   }
}
