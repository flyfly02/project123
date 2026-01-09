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
    private var tableHeightConstraint: NSLayoutConstraint!
    
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
        table.register(PlayerCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = 15
        table.layer.masksToBounds  = true
        table.separatorColor = .clear
        table.backgroundColor = .appBackBlack
        table.tintColor = .systemBlue
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
        updateTableHeight()
        
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

        ])
        tableHeightConstraint = table.heightAnchor.constraint(equalToConstant: 0)
        tableHeightConstraint.isActive = true
    }
    
    func updateTableHeight() {
        DispatchQueue.main.async {
            self.table.layoutIfNeeded()
            let tableTop = self.table.frame.origin.y
            let buttonTop = self.newGameButton.frame.origin.y
            let availableHeight = buttonTop - tableTop - 100
            
            let contentHeight = self.table.contentSize.height
            
            let newHeight = min(contentHeight, availableHeight)
            
            let minHeight: CGFloat = 44
            let finalHeight = max(newHeight, minHeight)
            
            UIView.animate(withDuration: 0.3) {
                self.tableHeightConstraint.constant = finalHeight
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count + 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerCell
        let isAddCell = indexPath.row == players.count
        cell.configure(isAddCell)
        cell.onTableButtonTapped = { [weak self] in
               guard let self = self else { return }
            
               if isAddCell {
                   self.navigationController?.pushViewController(AddPlayerVC(), animated: true)
                   self.newPlayer()
               } else {
                   self.deletePlayer(at: indexPath.row)
               }
           }
        

        if !isAddCell && indexPath.row < players.count {
            cell.cellName.text = players[indexPath.row]
        }
        
        cell.backgroundColor = .appBackBlack
        cell.contentView.backgroundColor = .appBackBlack
        
        return cell
    }

}

extension StartViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .appBackBlack
        
        let label = UILabel()
        label.text = "Players"
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

extension StartViewController {
    private func newPlayer() {
        players.append("Player \(players.count)")
        table.reloadData()
        updateTableHeight()
    }

    private func deletePlayer(at index: Int) {
        if index < players.count {
            players.remove(at: index)
            table.reloadData()
            updateTableHeight()
        }
    }
}





