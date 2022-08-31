//
//  NewsAPI.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import Foundation
import Moya

// 모야와 같이 사용하기 어려움

//enum NewsAPI {
//    case articles(NewsCountry)
//}
//
//extension NewsAPI: TargetType {
//    var baseURL: URL {
//        return URL(string: URLs.rootURL)!
//    }
//
//    var path: String {
//        switch self {
//        case .articles:
//            return URLs.topHeadlines
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .articles:
//            return .get
//        }
//    }
//
//    var task: Task {
//        switch self {
//        case .articles(let country):
//            return .requestParameters(parameters: [
//                "country": country,
//                "apikey": URLs.apiKey
//            ], encoding: URLEncoding.queryString)
//        }
//    }
//
//    var headers: [String : String]? {
//        switch self {
//        case .articles:
//            return nil
//        }
//    }
//}

enum NewsCountry: String {
    case kr
    case us
}
