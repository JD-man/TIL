//
//  NewsComponent.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import Foundation
import ComposableArchitecture
import Moya
import CombineMoya
import SwiftUI
import Combine

struct NewsComponent: ComponentType {
    struct State: Equatable {
        var articles: [Article] = []
    }
    enum Action: Equatable {
        case onAppear
        case setArticles(TaskResult<[Article]>)
    }
    struct Environment {
        let articles: (NewsCountry) async throws -> [Article]
    }

    var reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .onAppear:
            return .task {
                await .setArticles(TaskResult { try await environment.articles(.kr) } )
            }
        case .setArticles(.success(let articles)):
            state.articles = articles
            return .none
        case .setArticles(.failure(let error)):
            print(error)
            return .none
        }
    }
    
    // State 초기값을 설정하는 경우 사용
    init() { }
}
