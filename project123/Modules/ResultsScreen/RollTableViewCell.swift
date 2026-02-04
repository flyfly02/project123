//
//  RollTableViewCell.swift
//  project123
//
//  Created by Илья Богуш on 4.02.26.
//

import Foundation
import UIKit

class RollTableViewCell: UITableViewCell {
    
    private lazy var rollValue: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.text = "#"
       label.font = .nunitoExtraBold(size: 20)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    private lazy var playerName: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.text = "#"
       label.font = .nunitoExtraBold(size: 20)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(rollValue)
        contentView.addSubview(playerName)
        setupConstraints()
        contentView.backgroundColor = .appBackBlack
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rollValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rollValue.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            playerName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            playerName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(rollValue: Int, playerName: String) {
        if rollValue > 0 {
            self.rollValue.text = "+\(rollValue)"
        } else if rollValue < 0 {
            self.rollValue.text = "\(rollValue)"
        } else {
            self.rollValue.text = "\(rollValue)"
        }
        self.playerName.text = playerName
    }
}
