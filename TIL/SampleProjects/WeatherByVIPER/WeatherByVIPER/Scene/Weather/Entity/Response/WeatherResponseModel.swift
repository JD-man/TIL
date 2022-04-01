//
//  WeatherModel.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation

//let temperature = json["main"]["temp"].intValue
//let humidity = json["main"]["humidity"].stringValue
//let windSpeed = json["wind"]["speed"].stringValue
//let statusIcon = json["weather"][0]["icon"].stringValue
//
//let weather = Weather(temperature: "\(temperature)",
//                      humidity: humidity,
//                      windSpeed: windSpeed,
//                      statusImageURL: statusImageURL)


struct WeatherResponseModel: Codable {
    let temp: Int
    let humidity: String
    let speed: String
    let icon: String
}
