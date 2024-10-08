//
//  ViewController.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import UIKit
import RxSwift
import SnapKit

class WeatherViewController: UIViewController, WeatherViewType {
    
    private let temperatureLabel = WeatherBaseLabel()
    private let humidityLabel = WeatherBaseLabel()
    private let speedLabel = WeatherBaseLabel()
    private let iconImageView = WeatherBaseImageView()
    
    var presenter: WeatherPresenter
    private var disposeBag = DisposeBag()
    
    init(presenter: WeatherPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        binding()
    }
    
    private func viewConfig() {
        let baseOffset = 16
        view.backgroundColor = .systemGreen
        [temperatureLabel, humidityLabel, speedLabel, iconImageView].forEach {
            view.addSubview($0)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(baseOffset)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.leading.equalTo(temperatureLabel)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(baseOffset)
        }
        
        speedLabel.snp.makeConstraints { make in
            make.leading.equalTo(temperatureLabel)
            make.top.equalTo(humidityLabel.snp.bottom).offset(baseOffset)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(temperatureLabel)
            make.top.equalTo(speedLabel.snp.bottom).offset(baseOffset)
            make.width.height.equalTo(100)
        }
    }
    
    private func binding() {
        let output = presenter.transform()
        
        Observable.just(())
            .bind(to: presenter.input.viewDidLoad)
            .disposed(by: disposeBag)
        
        output.tempDriver
            .drive(temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.humidityDriver
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.speedDriver
            .drive(speedLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.iconDriver
            .drive(iconImageView.rx.iconImage)
            .disposed(by: disposeBag)
    }
}

