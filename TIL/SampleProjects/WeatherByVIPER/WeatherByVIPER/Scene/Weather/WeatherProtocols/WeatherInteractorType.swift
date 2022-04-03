//
//  InteractorType.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation
import RxSwift

protocol WeatherInteractorType {
    func fetchWeatherData() -> Single<WeatherResponseModel>
}
