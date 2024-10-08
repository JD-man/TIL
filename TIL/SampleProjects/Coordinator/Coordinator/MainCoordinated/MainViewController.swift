//
//  ViewController.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//

import UIKit

class MainViewController: UIViewController, Coordinated {
    
    let pushSecondVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push SecondVC", for: .normal)
        button.backgroundColor = .link
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushSecondVCButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let pushThirdVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push ThirdVC", for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushThirdVCButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let addCoordinatorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Coordinator", for: .normal)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addCoordinateButtonClicked), for: .touchUpInside)
        return button
    }()
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()        
        view.backgroundColor = .systemBackground
        view.addSubview(pushSecondVCButton)
        view.addSubview(pushThirdVCButton)
        view.addSubview(addCoordinatorButton)
        
        pushSecondVCButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        pushSecondVCButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        pushSecondVCButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        pushSecondVCButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pushThirdVCButton.topAnchor.constraint(equalTo: pushSecondVCButton.bottomAnchor, constant: 10).isActive = true
        pushThirdVCButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        pushThirdVCButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        pushThirdVCButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addCoordinatorButton.topAnchor.constraint(equalTo: pushThirdVCButton.bottomAnchor, constant: 10).isActive = true
        addCoordinatorButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        addCoordinatorButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        addCoordinatorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func pushSecondVCButtonClicked() {
        coordinator?.pushSecondVC()
    }
    
    @objc private func pushThirdVCButtonClicked() {
        coordinator?.pushThirdVC()
    }
    
    @objc private func addCoordinateButtonClicked() {
        coordinator?.addCoordinate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(coordinator?.childCoordinators)
    }
}

