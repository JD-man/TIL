//
//  WeatherModel.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation

struct WeatherResponseModel: Codable {
    let main: WeatherMain
    let wind: WeatherWind
    let weather: [WeatherDetail]
}

struct WeatherMain: Codable {
    let temp: Double
    let humidity: Double
}

struct WeatherWind: Codable {
    let speed: Double
}

struct WeatherDetail: Codable {
    let icon: String
}

