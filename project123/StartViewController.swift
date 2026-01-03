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
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "addCell")
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appMainBlack
        view.addSubview(titletext)
        setupConstraints()
        
    }


}

extension StartViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titletext.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titletext.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        ])
    }
}

extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "addCell", for: <#T##IndexPath#>)
    }
    
}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

