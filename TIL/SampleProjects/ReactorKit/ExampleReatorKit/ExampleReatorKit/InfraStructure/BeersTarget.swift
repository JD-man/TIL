//
//  BeersTarget.swift
//  ExampleReatorKit
//
//  Created by JD_MacMini on 2022/03/02.
//

import Foundation
import Moya

enum BeersTarget {
    case getBeers(parameters: [String: Any])
}

extension BeersTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.punkapi.com")!
    }
    
    var path: String {
        switch self {
        case .getBeers:
            return "/v2/beers"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBeers:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getBeers(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
