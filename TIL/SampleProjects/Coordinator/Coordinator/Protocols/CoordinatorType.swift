//
//  CoordinatorType.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
