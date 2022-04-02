//
//  RouterType.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import UIKit

protocol RouterType: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
