//
//  WeatherInteractor.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation
import RxSwift
import Moya

final class WeatherInteractor: WeatherInteractorType {
    let provider = MoyaProvider<WeatherTarget>()
    
    func fetchWeatherData() -> Single<WeatherResponseModel> {
        let parameters = WeatherRequestModel().toParameter()
        return Single<WeatherResponseModel>.create { [weak self] single in
            self?.provider.request(.getWeatherInfo(parameters: parameters), completion: { result in
                switch result {
                case .success(let response):
                    guard let model = try? response.map(WeatherResponseModel.self) else { return }
                    single(.success(model))
                case .failure(let error):
                    print(error)
                    single(.failure(error))
                }
            })
            return Disposables.create()
        }
    }
}
