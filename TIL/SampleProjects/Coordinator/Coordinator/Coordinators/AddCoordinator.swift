//
//  AddCoordinator.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/20.
//

import UIKit

class AddCoordinator: NSObject, CoordinatorType {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators: [CoordinatorType] = []
    var navigationController: UINavigationController
    
    init(nav : UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        // first VC of child coordinator include
        let addVC = AddViewController()
        addVC.coordinator = self
        navigationController.pushViewController(addVC, animated: true)        
    }
    
    func pushSecondVC() {
        let addSecondVC = AddSecondViewController()
        addSecondVC.coordinator = self
        navigationController.pushViewController(addSecondVC, animated: true)
    }
    
    // child coordinator must have finish method
    func didFinishAdd() {
        parentCoordinator?.childDidFinish(self)
    }
}
