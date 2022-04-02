//
//  ViewController.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import UIKit
import SnapKit

// 신림역 - 37.48433605595456, 126.92985099999653

class WeatherViewController: UIViewController {
    
    private let temperatureLabel = WeatherBaseLabel()
    private let humidityLabel = WeatherBaseLabel()
    private let speedLabel = WeatherBaseLabel()
    private let iconImageView = WeatherBaseImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
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
}

