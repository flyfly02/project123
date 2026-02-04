//
//  ResultsViewController.swift
//  project123
//
//  Created by Илья Богуш on 3.02.26.
//

import UIKit
import Combine

class ResultsViewController: UIViewController {
    
    private let viewModel = Assembly.shared.createResultsVcViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Results"
        label.font = .nunitoExtraBold(size: 36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playersResultsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(ResultsPlayersCell.self, forCellWithReuseIdentifier: "PlayersResultsCell")
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var rollsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(RollTableViewCell.self, forCellReuseIdentifier: "TableCell")
        table.layer.cornerRadius = 15
        table.layer.masksToBounds  = true
        table.separatorColor = .clear
        table.backgroundColor = .appBackBlack
        table.tintColor = .systemBlue
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var leftNewGameButton = AppButtonFactory.createBarItem("New Game", self,#selector(newGameButtonTapped))
    private lazy var rightResultsButton = AppButtonFactory.createBarItem("Resume", self, #selector(resumeButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchAllPlayers()
        viewModel.fetchAllRolls()
    }
    
    private func setupUI() {
        let leftSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
           leftSpacer.width = 12
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
           rightSpacer.width = 12
        self.navigationItem.leftBarButtonItems = [leftSpacer, leftNewGameButton]
        self.navigationItem.rightBarButtonItems = [rightSpacer, rightResultsButton]
        view.backgroundColor = .appMainBlack
        view.addSubview(resultsLabel)
        view.addSubview(playersResultsCollection)
        view.addSubview(rollsTable)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resultsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            playersResultsCollection.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 20),
            playersResultsCollection.leadingAnchor.constraint(equalTo: resultsLabel.leadingAnchor),
            playersResultsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playersResultsCollection.heightAnchor.constraint(equalToConstant: 200),

            rollsTable.topAnchor.constraint(equalTo: playersResultsCollection.bottomAnchor, constant: 50),
            rollsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rollsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rollsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
    }
    
    private func setupBindings() {
        viewModel.$players
            .receive(on: DispatchQueue.main)
            .sink { [weak self] players in
                self?.playersResultsCollection.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$rolls
            .receive(on: DispatchQueue.main)
            .sink { [weak self] rolls in
                self?.rollsTable.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersResultsCell", for: indexPath) as! ResultsPlayersCell
        let player = viewModel.players[indexPath.row]
        cell.configure(place:String(indexPath.row + 1) , score:player.score , name: player.name)
        return cell
    }
}

extension ResultsViewController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 44)
    }
}

extension ResultsViewController {
    @objc private func resumeButtonTapped() {
        let vc = GameScreenVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func newGameButtonTapped() {
        let vc = StartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rolls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! RollTableViewCell
        cell.configure(rollValue: viewModel.rolls[indexPath.row].value, playerName: viewModel.rolls[indexPath.row].playerName)
        cell.backgroundColor = .appBackBlack
        cell.contentView.backgroundColor = .appBackBlack
        
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .appBackBlack
        
        let label = UILabel()
        label.text = "Turns"
        label.textColor = .white
        label.font = .nunitoSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(lessThanOrEqualTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.subviews
            .filter { $0.frame.height <= 1 }
            .forEach { $0.removeFromSuperview() }

        if indexPath.row > 0 {
            let separator = UIView(frame: CGRect(x: 16, y: 0, width: cell.frame.width - 32, height: 0.5))
            separator.backgroundColor = .appSeparatorTable
            cell.addSubview(separator)
        }
    }
}
