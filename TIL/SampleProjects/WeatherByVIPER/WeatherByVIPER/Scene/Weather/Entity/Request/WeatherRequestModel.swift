//
//  WeatherRequestModel.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/01.
//

import Foundation

//    let lat = URLQueryItem(name: "lat", value: latitude)
//    let lon = URLQueryItem(name: "lon", value: longitude)
//    let temp = URLQueryItem(name: "units", value: "metric")
//    let appid = URLQueryItem(name: "appid", value: key)

struct WeatherRequestModel {
    let lat: Double = 37.48433605595456
    let lon: Double = 126.92985099999653
    let units: String = "metric"
}

extension WeatherRequestModel {
    func toParameter() -> [String: Any] {
        return [
            "lat": lat,
            "lon": lon,
            "units": units,
            "appid": URLComponents.key
        ]
    }
}
