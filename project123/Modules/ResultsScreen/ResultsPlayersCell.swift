//
//  ResultsPlayersCell.swift
//  project123
//
//  Created by Илья Богуш on 3.02.26.
//

import Foundation
import UIKit

class ResultsPlayersCell: UICollectionViewCell {
    
     private lazy var placePlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "#"
        label.font = .nunitoExtraBold(size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private lazy var namePlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appCollectionPlayerName
        label.font = .nunitoExtraBold(size: 28)
        label.text = "TEST_NAME"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private lazy var playerScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .nunitoExtraBold(size: 28)
        label.text = "TEST_SCORE"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(placePlayerLabel)
        contentView.addSubview(namePlayerLabel)
        contentView.addSubview(playerScoreLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placePlayerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placePlayerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            namePlayerLabel.leadingAnchor.constraint(equalTo: placePlayerLabel.trailingAnchor, constant: 10),
            placePlayerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playerScoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playerScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(place: String, score: Int, name: String) {
        placePlayerLabel.text = "#" + place
        playerScoreLabel.text = String(score)
        namePlayerLabel.text = name
    }
}
