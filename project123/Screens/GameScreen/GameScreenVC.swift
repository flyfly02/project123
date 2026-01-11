//
//  GameScreenVC.swift
//  project123
//
//  Created by Илья Богуш on 10.01.26.
//

import UIKit

class GameScreenVC: UIViewController {
    
    private lazy var leftNewGameButton = AppBarButtonItem.createButton("New Game", nil, nil)
    private lazy var rightResultsButton = AppBarButtonItem.createButton("Results", nil, nil)
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.text = "Game"
        label.font = .nunitoExtraBold(size: 36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var diceImageView: UIImageView = {
        let dice = UIImageView()
        dice.image = UIImage(systemName: "die.face.4")
        dice.tintColor = .white
        dice.translatesAutoresizingMaskIntoConstraints = false
        return dice
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .appMainBlack
        self.navigationItem.leftBarButtonItem = leftNewGameButton
        self.navigationItem.rightBarButtonItem = rightResultsButton
        view.addSubview(gameLabel)
        view.addSubview(diceImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            gameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     
            diceImageView.bottomAnchor.constraint(equalTo: gameLabel.bottomAnchor),
            diceImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            diceImageView.heightAnchor.constraint(equalTo: gameLabel.heightAnchor),
            diceImageView.widthAnchor.constraint(equalTo: gameLabel.heightAnchor),
        
        
        ])

    }

}
