//
//  PlayerCell.swift
//  project123
//
//  Created by Илья Богуш on 8.01.26.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.5
        button.setTitleColor(.white, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
     let cellName: UILabel = {
        let name = UILabel()
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var onTableButtonTapped: (() -> Void)?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .appBackBlack
        contentView.addSubview(actionButton)
        contentView.addSubview(cellName)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 25),
            actionButton.heightAnchor.constraint(equalToConstant: 25),
            
            cellName.leadingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: 16),
            cellName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellName.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(_ isAdd: Bool) {
        if isAdd {
            actionButton.setTitle("+", for: .normal)
            actionButton.backgroundColor = .appGreen
            actionButton.titleLabel?.font = .systemFont(ofSize: 20)
            cellName.textColor = .appGreen
            cellName.text = "Add player"
            cellName.font = .nunitoSemiBold(size: 16)
        } else {
            actionButton.setTitle("−", for: .normal)
            actionButton.titleLabel?.font = .systemFont(ofSize: 24)
            actionButton.titleEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
            actionButton.backgroundColor = .appRed
            cellName.textColor = .white
            cellName.text = "Player"
            cellName.font = .nunitoSemiBold(size: 20)
        }
    }
}

extension PlayerCell {
    @objc private func buttonTapped() {
        onTableButtonTapped?()
    }
}
