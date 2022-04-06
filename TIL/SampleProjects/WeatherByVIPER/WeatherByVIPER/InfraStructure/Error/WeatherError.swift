//
//  WeatherError.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/06.
//

import Foundation

enum WeatherError: Int, Error {
    case unknownError = 0
    case decodeFail
}

extension WeatherError {
    var description: String {
        switch self {
        case .unknownError:
            return "Unknown Error"
        case .decodeFail:
            return "Decode Fail"
        }
    }
}
