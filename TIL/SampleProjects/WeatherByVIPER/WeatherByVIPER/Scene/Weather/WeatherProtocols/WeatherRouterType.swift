//
//  WeatherRouterType.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/06.
//

import Foundation

protocol WeatherRouterType: RouterType {
    func alertWeatherAPIError(of error: Error)
}
