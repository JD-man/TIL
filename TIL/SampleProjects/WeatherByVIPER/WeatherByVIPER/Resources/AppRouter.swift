//
//  AppRouter.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/02.
//

import UIKit

final class AppRouter: RouterType {
    var navigationController: UINavigationController
    var childRouter: [RouterType] = []
    
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        startWithWeatherRouter()
    }
    
    private func startWithWeatherRouter() {
        let weatherRouter = WeatherRouter(nav: navigationController, parentRouter: self)
        childRouter.append(weatherRouter)        
        weatherRouter.start()
    }
}
