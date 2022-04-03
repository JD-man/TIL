//
//  WeatherTarget.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/02.
//

import Foundation
import Moya

typealias Parameters = [String: Any]

enum WeatherTarget {
    case getWeatherInfo(parameters: Parameters)
}


extension WeatherTarget: TargetType {
    var baseURL: URL {
        return URL(string:URLComponents.rootURL)!
    }
    
    var path: String {
        switch self {
        case .getWeatherInfo:
            return "/data/2.5/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWeatherInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getWeatherInfo:
            return nil
        }
    }
    
    var validationType: ValidationType {
        return .customCodes([200])
    }
}
