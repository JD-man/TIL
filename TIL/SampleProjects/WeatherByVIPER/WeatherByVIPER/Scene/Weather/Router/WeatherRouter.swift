//
//  WeatherRouter.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import UIKit

final class WeatherRouter: RouterType {
    var navigationController: UINavigationController
    weak var parentRouter: RouterType?
    
    init(nav: UINavigationController, parentRouter: RouterType) {
        self.navigationController = nav
        self.parentRouter = parentRouter
    }
    
    func start() {
        pushWeatherViewController()
    }
    
    func pushWeatherViewController() {
        let weatherVC = WeatherViewController()
        navigationController.pushViewController(weatherVC, animated: true)
    }
}
