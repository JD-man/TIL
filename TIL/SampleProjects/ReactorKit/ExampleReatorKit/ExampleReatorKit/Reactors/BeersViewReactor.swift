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
        case viewDidLoad
    }
    
    enum Mutation {
        case setBeersItem(items: [BeersItemModel], nextPage: Int)
    }
    
    struct State {
        var items: [BeersItemModel] = []
        var nextPage: Int = 0
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            print("viewWillAppear")
            return Observable.concat(
                getBeers(page: 1)
                    .map { Mutation.setBeersItem(items: $0.0, nextPage: $0.1) }
            )
        }
    }
        
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case .setBeersItem(let items, let nextPage):
            var newState = state
            newState.items = items
            newState.nextPage = nextPage
            return newState
        }
    }
    
    private func getBeers(page: Int, per_page: Int = 20) -> Observable<([BeersItemModel], Int)> {
        let parameters = ["page": page, "per_page": per_page]
        let provider = MoyaProvider<BeersTarget>()
        return Observable<([BeersItemModel], Int)>.create { observer in
            provider.request(.getBeers(parameters: parameters)) { result in
                switch result {
                case .success(let response):
                    guard let decoded = try? response.map([Beer].self) else {
                        print("decode fail")
                        return
                    }
                    let items = decoded.map { BeersItemModel(name: $0.name ?? "",
                                                                      imageURL: $0.imageURL ?? "",
                                                                      tagline: $0.tagline ?? "",
                                                                      description: $0.description ?? "")}
                    observer.onNext((items, page + 1))
                case .failure(let error):
                    print("API Error occur", error)
                }
            }
            return Disposables.create()
        }
    }
}
