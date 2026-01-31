//
//  PlayerCollectionCell.swift
//  project123
//
//  Created by Илья Богуш on 12.01.26.
//

import Foundation
import UIKit

class PlayerCollectionCell: UICollectionViewCell {
    
     lazy var playerName: UILabel = {
        let label = UILabel()
        label.textColor = .appCollectionPlayerName
        label.font = .nunitoExtraBold(size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var playerScore: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .nunitoBold(size: 41)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .appBackBlack
        layer.cornerRadius = 15
        clipsToBounds = true
        contentView.addSubview(playerName)
        contentView.addSubview(playerScore)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            playerName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            playerScore.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playerScore.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        ])
    }
}
