//
//  ViewController.swift
//  project123
//
//  Created by Илья Богуш on 3.01.26.
//

import UIKit

class StartViewController: UIViewController {
    
    private lazy var titletext: UILabel = {
        let title = UILabel()
        title.font = .nunito(size: 36)
        title.textColor = .white
        title.text = "Game Counter"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
//        table.dataSource = self
//        table.delegate = self
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "addCell")
//
        
        return table
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .appGreen
        button.setTitle("Start game", for: .normal)
        button.titleLabel?.font = .nunito(size: 24)
        button.tintColor = .white
        button.layer.shadowOffset = CGSize(width: 0, height: -10)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appMainBlack
        view.addSubview(titletext)
        view.addSubview(newGameButton)
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
            newGameButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}

//extension StartViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
//    }
//
//}
//
//extension StartViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//}

