//
//  PresenterType.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation

protocol PresenterType {
    var router: RouterType { get set }
    var interactor: InteractorType { get set }
}
