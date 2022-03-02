//
//  BeersViewReactor.swift
//  ExampleReatorKit
//
//  Created by JD_MacMini on 2022/03/02.
//

import ReactorKit
import RxSwift
import Moya

final class BeersViewReactor: Reactor {
    enum Action {
        case updateBeers
        case pagination
    }
    
    enum Mutation {
        case setBeersItem(items: [BeersItemModel], nextPage: Int)
        case addBeersItem(items: [BeersItemModel], nextPage: Int)
        case setLoadingStatus(status: Bool)
    }
    
    struct State {
        var items: [BeersItemModel] = []
        var nextPage: Int = 1
        var isLoading: Bool = false
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<BeersViewReactor.Mutation> {
        switch action {
        case .updateBeers:
            return getBeers(page: 1)
                    .map { Mutation.setBeersItem(items: $0.0, nextPage: $0.1) }
            
        case .pagination:
            guard self.currentState.isLoading == false else { return Observable.empty() }
            return Observable.concat([
                Observable.just(Mutation.setLoadingStatus(status: true)),
                getBeers(page: currentState.nextPage)
                    .map { Mutation.addBeersItem(items: $0.0, nextPage: $0.1) },
                Observable.just(Mutation.setLoadingStatus(status: false)),
                ])
        }
    }
        
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case .setBeersItem(let items, let nextPage):
            var newState = state
            newState.items = items
            newState.nextPage = nextPage
            return newState
        case .addBeersItem(let items, let nextPage):
            var newState = state
            newState.items.append(contentsOf: items)
            newState.nextPage = nextPage
            return newState
        case .setLoadingStatus(let status):
            var newState = state
            newState.isLoading = status
            return newState
        }
    }
    
    private func getBeers(page: Int, per_page: Int = 10) -> Observable<([BeersItemModel], Int)> {
        let parameters = ["page": page, "per_page": per_page]
        let provider = MoyaProvider<BeersTarget>()
        return Observable<([BeersItemModel], Int)>.create { observer in
            provider.request(.getBeers(parameters: parameters)) { result in
                switch result {
                case .success(let response):
                    guard let decoded = try? response.map([Beer].self) else { return }
                    let items = decoded.map { BeersItemModel(name: $0.name ?? "",
                                                             imageURL: $0.imageURL ?? "",
                                                             tagline: $0.tagline ?? "",
                                                             description: $0.description ?? "") }
                    observer.onNext((items, page + 1))
                    // concat 사용을 위해 complete이 되어야한다!
                    observer.onCompleted()
                case .failure(let error):
                    print("API Error occur", error)
                }
            }
            return Disposables.create {
                print("get beers disposed")
            }
        }
    }
}
