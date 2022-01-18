//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, CoordinatorType {
    
    var childCoordinators: [CoordinatorType] = []
    var navigationController: UINavigationController
    
    init(nav : UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushSecondVC() {
        let vc = SecondViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushThirdVC() {
        let vc = ThirdViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
