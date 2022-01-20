//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//
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
    
    func addCoordinate() {
        let child = AddCoordinator(nav: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: CoordinatorType?) {
        for (idx, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: idx)
                break
            }
        }
    }
}
