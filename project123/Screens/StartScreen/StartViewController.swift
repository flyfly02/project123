//
//  ViewController.swift
//  project123
//
//  Created by Илья Богуш on 3.01.26.
//

import UIKit

class StartViewController: UIViewController {
    
    private let addPlayer = "Add player"
    private var players: [String] = ["mike", "anna", "polly"]
    
    private lazy var titletext: UILabel = {
        let title = UILabel()
        title.font = .nunitoExtraBold(size: 36)
        title.textColor = .white
        title.text = "Game Counter"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.setEditing(true, animated: false)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = 15
        table.layer.masksToBounds  = true
        table.backgroundColor = .appBackBlack
        table.separatorColor = .appSeparatorTable
        table.translatesAutoresizingMaskIntoConstraints = false

        
        return table
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .appGreen
        button.setTitle("Start game", for: .normal)
        button.titleLabel?.font = .nunitoExtraBold(size: 24)
        button.tintColor = .white
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowColor = UIColor.appButtonShadow?.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appMainBlack
        view.addSubview(titletext)
        view.addSubview(newGameButton)
        view.addSubview(table)
        setupConstraints()
        
    }
}

extension StartViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titletext.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titletext.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            newGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            newGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            newGameButton.heightAnchor.constraint(equalToConstant: 65),
            
            table.topAnchor.constraint(equalTo: titletext.bottomAnchor, constant: 50),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            table.bottomAnchor.constraint(lessThanOrEqualTo: newGameButton.topAnchor, constant: -20),
            table.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
}

extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count + 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        if indexPath.row == players.count {
            // Последняя ячейка - "Add player"
            content.text = "Add player"
            content.textProperties.color = .appGreen ?? .green
            content.textProperties.font = .nunitoSemiBold(size: 16) ?? .systemFont(ofSize: 26)
        } else {
            // Обычные ячейки с игроками
            content.text = players[indexPath.row]
            content.textProperties.color = .white
            content.textProperties.font = .nunitoSemiBold(size: 20) ?? .systemFont(ofSize: 26)
        }
        
        cell.contentConfiguration = content
        cell.backgroundColor = .appBackBlack
        
        return cell 
    }

}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == players.count {
            return .insert
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаляем игрока
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Добавляем нового игрока
            players.append("Player \(players.count)")
            tableView.insertRows(at: [IndexPath(row: players.count - 1, section: 0)], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Players" // или "Игроки"
        }
        
        // Настройка внешнего вида заголовка
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = .white
            header.textLabel?.font = .nunitoSemiBold(size: 16)
            header.textLabel?.textAlignment = .left
            header.backgroundColor = .clear
            header.textLabel?.translatesAutoresizingMaskIntoConstraints = false
               header.textLabel?.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16).isActive = true
               header.textLabel?.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16).isActive = true
           
            
            
        }

}





