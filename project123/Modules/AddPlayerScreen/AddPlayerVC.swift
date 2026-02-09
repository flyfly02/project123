//
//  AddPlayerVC.swift
//  project123
//
//  Created by Илья Богуш on 9.01.26.
//

import UIKit
import Combine

class AddPlayerVC: UIViewController {
    
    private let viewModel = Assembly.shared.createAddPlayerViewModel()
    private var cancellables = Set<AnyCancellable>()
    private lazy var titletext: UILabel = {
        let title = UILabel()
        title.font = .nunitoExtraBold(size: 36)
        title.textColor = .white
        title.text = "Add Player"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var addPlayerTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .appBackBlack
        textfield.textColor = .white
        textfield.font = .nunitoExtraBold(size: 20)
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 0))
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.appGray!,
            .font: UIFont.nunitoExtraBold(size: 20)!
        ]
        textfield.attributedPlaceholder = NSAttributedString(string: "Player Name", attributes: attributes)
        return textfield
    }()
    
    private lazy var rightAddButton = AppButtonFactory.createBarItem("Add", self, #selector(addTapped))
    private lazy var leftBackButton = AppButtonFactory.createBarItem("Back", self, #selector(backTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        addPlayerTextField.textPublisher
            .assign(to: \.name, on: viewModel)
                   .store(in: &cancellables)
           
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            addPlayerTextField.becomeFirstResponder()
        }
    
    private func setupUi() {
        view.backgroundColor = .appMainBlack
        view.addSubview(titletext)
        view.addSubview(addPlayerTextField)
        view.tintColor = .appGreen
        setupConstraints()
        navigationItem.rightBarButtonItem = rightAddButton
        navigationItem.leftBarButtonItem = leftBackButton
        
        
    }
    
   
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titletext.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titletext.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            addPlayerTextField.topAnchor.constraint(equalTo: titletext.bottomAnchor, constant: 50),
            addPlayerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addPlayerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addPlayerTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension AddPlayerVC {
    @objc private func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addTapped() {
        if  viewModel.createUser() != nil {
                navigationController?.popViewController(animated: true)
            }
        }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}


