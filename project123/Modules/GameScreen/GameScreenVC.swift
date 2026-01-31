//
//  GameScreenVC.swift
//  project123
//
//  Created by Илья Богуш on 10.01.26.
//

import UIKit
import Combine

class GameScreenVC: UIViewController {
    
    private let viewModel = Assembly.shared.createGameScreenViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var isGameIsOn: Bool = false
    private var gameTimer: Timer?
    private var timerSeconds: Int = 0
    private lazy var leftNewGameButton = AppButtonFactory.createBarItem("New Game", nil, nil)
    private lazy var rightResultsButton = AppButtonFactory.createBarItem("Results", nil, nil)
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.text = "Game"
        label.font = .nunitoExtraBold(size: 36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rollImageView: UIImageView = {
        let dice = UIImageView()
        dice.image = UIImage(named: "dice_4")
        dice.contentMode = .scaleToFill
        dice.translatesAutoresizingMaskIntoConstraints = false
        return dice
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .appMainBlack
        label.font = .nunitoExtraBold(size: 28)
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timerButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleToFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(PlayerCollectionCell.self, forCellWithReuseIdentifier: "PlayerCell")
        
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "undoImage"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var smallButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        var value: Int = -10
        for i in 0...4{
            let button = AppButtonFactory.createChangePlayerScore(value, 55, .nunitoExtraBold(size: 25)!)
            button.tag = value
            button.addTarget(self, action: #selector(changeScoreButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            value = value + 5
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var bigButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        let previousButton = AppButtonFactory.createImageButton("previousImage")
        previousButton.addTarget(self, action: #selector(scrollToPreviousPlayer), for: .touchUpInside)
        let bigChangeScoreButton = AppButtonFactory.createChangePlayerScore(10, 90, .nunitoExtraBold(size: 40)!)
        bigChangeScoreButton.tag = 10
        bigChangeScoreButton.addTarget(self, action: #selector(changeScoreButtonTapped(_:)), for: .touchUpInside)
        let nextButton = AppButtonFactory.createImageButton("nextImage")
        nextButton.addTarget(self, action: #selector(scrollToNextPlayer), for: .touchUpInside)
        previousButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        [previousButton, bigChangeScoreButton, nextButton].forEach {
                stackView.addArrangedSubview($0)
            }
                                                                            
                                                                            
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPlayers()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = playersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
            playersCollectionView.collectionViewLayout.invalidateLayout()
            playersCollectionView.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        
        let leftSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
           leftSpacer.width = 12
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
           rightSpacer.width = 12
        view.backgroundColor = .appMainBlack
        self.navigationItem.leftBarButtonItems = [leftSpacer, leftNewGameButton]
        self.navigationItem.rightBarButtonItems = [rightSpacer, rightResultsButton]
        view.addSubview(gameLabel)
        view.addSubview(rollImageView)
        view.addSubview(timerLabel)
        view.addSubview(timerButton)
        view.addSubview(playersCollectionView)
        view.addSubview(undoButton)
        view.addSubview(smallButtonsStackView)
        view.addSubview(bigButtonsStackView)
        setupTimerUI(timerLabel, timerButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     
            rollImageView.centerYAnchor.constraint(equalTo: gameLabel.centerYAnchor),
            rollImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rollImageView.heightAnchor.constraint(equalToConstant: 30),
            rollImageView.widthAnchor.constraint(equalToConstant: 30),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 15),
            
            timerButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 20),
            timerButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            timerButton.widthAnchor.constraint(equalToConstant:  16),
            timerButton.heightAnchor.constraint(equalToConstant:  21),
            
            playersCollectionView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            playersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playersCollectionView.bottomAnchor.constraint(equalTo: bigButtonsStackView.topAnchor, constant: -20),
            
            undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            undoButton.widthAnchor.constraint(equalToConstant:  15),
            undoButton.heightAnchor.constraint(equalToConstant:  20),
            
            smallButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            smallButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            smallButtonsStackView.heightAnchor.constraint(equalToConstant: 55),
            smallButtonsStackView.bottomAnchor.constraint(equalTo: undoButton.topAnchor, constant: -20),
            
            bigButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46),
            bigButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46),
            bigButtonsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16),
            bigButtonsStackView.bottomAnchor.constraint(equalTo: smallButtonsStackView.topAnchor, constant: -10)
            
        ])
    }
}

extension GameScreenVC {
    private func setupTimerUI(_ timerLabel: UILabel, _ timerButton: UIButton) {
        if isGameIsOn {
            timerLabel.textColor = .white
            timerButton.setImage(UIImage(named: "pauseImage"), for: .normal)
        } else {
            timerLabel.textColor = .appTimerIsOff
            timerButton.setImage(UIImage(named: "playImage"), for: .normal)
        }
    }
    private func setupTimerLogic() {
        
    }
    
    @objc private func timerButtonTapped() {
        if isGameIsOn {
            stopGameTimer()
        } else {
            startTimer()
        }
        
        isGameIsOn.toggle()
        setupTimerUI(timerLabel, timerButton)
        
    }
    
    private func startTimer() {
        updateTimerLabel()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(timerTick),
                                         userInfo: nil,
                                         repeats: true)
        if let timer = gameTimer {
                    RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    @objc private func timerTick() {
        timerSeconds += 1
        updateTimerLabel()
    }
    
    private func updateTimerLabel() {
           let minutes = timerSeconds / 60
           let seconds = timerSeconds % 60
           timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func stopGameTimer() {
            gameTimer?.invalidate()
    }

}

extension GameScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCollectionCell
        cell.playerName.text = viewModel.players[indexPath.row].name
        cell.playerScore.text = String(viewModel.players[indexPath.row].score)
        return cell
    }
}

extension GameScreenVC {
    @objc private func undoButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GameScreenVC: UICollectionViewDelegateFlowLayout {
    
    // 🎯 Этот метод вызывается для КАЖДОЙ ячейки
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 1. Получаем текущую высоту коллекции
        let collectionHeight = collectionView.frame.height
        
        // 2. Получаем отступы из layout
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 200, height: 100) // Запасной вариант
        }
        
        // 3. Вычисляем высоту ячейки
        // Высота = высота коллекции - верхний отступ - нижний отступ
        let topInset = flowLayout.sectionInset.top
        let bottomInset = flowLayout.sectionInset.bottom
        let cellHeight = collectionHeight - topInset - bottomInset
        
        // 4. Ширина ячейки = 68% от ширины экрана (как у тебя было)
        let cellWidth = view.frame.width * 0.68
        
        // 5. Минимальная высота на всякий случай
        let finalHeight = max(cellHeight, 100)
        
        print("📏 Высота коллекции: \(collectionHeight), Высота ячейки: \(finalHeight)")
        
        return CGSize(width: cellWidth, height: finalHeight)
    }
}

extension GameScreenVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == playersCollectionView {
            findCurrentCell()
        }
    }
    
    private func findCurrentCell() {
        let centerX = playersCollectionView.contentOffset.x + playersCollectionView.frame.width / 2
        let centerPoint = CGPoint(x: centerX, y: playersCollectionView.frame.height / 2)
        if let indexPath = playersCollectionView.indexPathForItem(at: centerPoint) {
            print("🎯 Текущий игрок: \(indexPath.row)")
            viewModel.currentPlayerIndex = indexPath.row
        }
    }
    
    func scrollToPlayer(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        
        playersCollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,  // Позиция на экране
            animated: true               // С анимацией или без
        )
    }
    
    @objc private func scrollToNextPlayer() {
        let currentInd = viewModel.currentPlayerIndex
        if currentInd < viewModel.players.count - 1 {
        scrollToPlayer(at: currentInd + 1)
        }
    }
    
    @objc private func scrollToPreviousPlayer() {
        let currentInd = viewModel.currentPlayerIndex
        if currentInd > 0 {
        scrollToPlayer(at: currentInd - 1)
        }
    }
}

extension GameScreenVC {
    @objc private func changeScoreButtonTapped(_ sender: UIButton) {
        let value = sender.tag
        let currentPlayer = viewModel.players[viewModel.currentPlayerIndex]
        let newScore = currentPlayer.score + value
        viewModel.updateScore(currentPlayer, newScore)
        playersCollectionView.reloadData()
    }
}
