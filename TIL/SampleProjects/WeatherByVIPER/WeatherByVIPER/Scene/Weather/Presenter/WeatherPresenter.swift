//
//  WeatherPresenter.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class WeatherPresenter: WeatherPresenterType {
    
    private var disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct Output {
        let tempDriver: Driver<String>
        let humidityDriver: Driver<String>
        let speedDriver: Driver<String>
        let iconDriver: Driver<String>
    }
    
    var router: WeatherRouterType
    var interactor: WeatherInteractorType
    var weatherResponseRelay = PublishRelay<WeatherResponseModel>()
    
    var input = Input()
    
    init(router: WeatherRouterType, interactor: WeatherInteractorType) {
        self.router = router
        self.interactor = interactor
    }
    
    func transform() -> Output {
        
        input.viewDidLoad
            .withUnretained(self)
            .flatMapLatest { $0.0.interactor.fetchWeatherData() }
            .catch { [weak self] in
                self?.router.alertWeatherAPIError(of: $0)
                return Observable.empty() }
            .bind(to: weatherResponseRelay)
            .disposed(by: disposeBag)
        
        let tempDriver = weatherResponseRelay.map { "온도: \($0.main.temp)" }.asDriver(onErrorJustReturn: "")
        let humidityDriver = weatherResponseRelay.map { "습도: \($0.main.humidity)" }.asDriver(onErrorJustReturn: "")
        let speedDriver = weatherResponseRelay.map { "풍속: \($0.wind.speed)" }.asDriver(onErrorJustReturn: "")
        let iconDriver = weatherResponseRelay.map { $0.weather[0].icon }.asDriver(onErrorJustReturn: "")
        
        return Output(
            tempDriver: tempDriver,
            humidityDriver: humidityDriver,
            speedDriver: speedDriver,
            iconDriver: iconDriver
        )
    }
}
