//
//  SecondViewController.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//

import UIKit

class SecondViewController: UIViewController, Coordinated {    
    weak var coordinator: MainCoordinator?
    
    let pushSecondVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push SecondVC", for: .normal)
        button.backgroundColor = .link
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushSecondVCButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        view.addSubview(pushSecondVCButton)
        pushSecondVCButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        pushSecondVCButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        pushSecondVCButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        pushSecondVCButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func pushSecondVCButtonClicked() {
        coordinator?.pushSecondVC()
    }
}
