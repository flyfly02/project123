//
//  GameScreenVC.swift
//  project123
//
//  Created by Илья Богуш on 10.01.26.
//

import UIKit

class GameScreenVC: UIViewController {
    
    private var isGameIsOn: Bool = false
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
        layout.itemSize = CGSize(width: 180, height: view.frame.height * 0.36)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
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
        return button
    }()
    
    private lazy var smallButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        var value: Int = -10
        for i in 0...5{
            stackView.addArrangedSubview(AppButtonFactory.createChangePlayerScore(value, 55))
            value = value + 5
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
            
            playersCollectionView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),
            playersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playersCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.37 ),
            
            undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            undoButton.widthAnchor.constraint(equalToConstant:  15),
            undoButton.heightAnchor.constraint(equalToConstant:  20),
            
            smallButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            smallButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            smallButtonsStackView.heightAnchor.constraint(equalToConstant: 55),
            smallButtonsStackView.bottomAnchor.constraint(equalTo: undoButton.topAnchor, constant: -20)
            
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
        isGameIsOn.toggle()
        setupTimerUI(timerLabel, timerButton)
    }

}

extension GameScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath)
        return cell
    }
}
