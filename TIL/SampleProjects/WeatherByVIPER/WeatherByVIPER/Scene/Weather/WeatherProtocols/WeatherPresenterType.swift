//
//  PresenterType.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation
import RxSwift

protocol WeatherPresenterType {
    var router: WeatherRouterType { get set }
    var interactor: WeatherInteractorType { get set }
}
