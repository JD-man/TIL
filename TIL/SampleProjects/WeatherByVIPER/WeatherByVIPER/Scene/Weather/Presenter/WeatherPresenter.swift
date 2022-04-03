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
        let weatherResponse = PublishRelay<WeatherResponseModel>()
    }
    
    var router: RouterType
    var interactor: WeatherInteractorType
    
    var input = Input()
    var output = Output()
    
    init(router: RouterType, interactor: WeatherInteractorType) {
        self.router = router
        self.interactor = interactor
        binding()
    }
    
    func binding() {
        input.viewDidLoad
            .withUnretained(self)
            .flatMapLatest { (presenter, signal) in
                presenter.interactor.fetchWeatherData()
            }.bind(to: output.weatherResponse)
            .disposed(by: disposeBag)
    }
}
