//
//  ThirdViewController.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//

import UIKit

class ThirdViewController: UIViewController, Coordinated {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
    }
}
