# ReactorKit 예제만들기

- [Punk API](https://punkapi.com/)를 이용해 맥주정보 가져오기!
- [참고예제](https://github.com/ReactorKit/ReactorKit/tree/master/Examples/GitHubSearch) 
### 목차
1. UI 만들기
2. Reactor 만들기
3. View 만들기, bind
4. Pagination
5. 결과

---

## 1. UI 만들기
- 스토리보드 없애고 BeersViewController와 BeersViewReactor 스위프트 파일 제작
- SceneDelegate UIWindow 설정
- BeersViewController에 TableView 추가, cell 제작

## 2. Reactor 만들기
### 구성요소
```swift
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
```

- Action: viewDidLoad API 호출
- Mutation: State의 items와 nextPage 업데이트
- State: 테이블뷰에 사용할 items와 Pagination을 위한 nextPage


### mutate
```swift
// Action -> Mutation
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

// API 호출 메서드
private func getBeers(page: Int, per_page: Int = 20)
 -> Observable<([BeersItemModel], Int)> {
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
            let items = decoded.map { 
                BeersItemModel(name: $0.name ?? "",
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
```

- mutate()에서 API 호출을해주고 Action을 Mutation으로 변환

### reduce
```swift
func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    case .setBeersItem(let items, let nextPage):
        var newState = state
        newState.items = items
        newState.nextPage = nextPage
        return newState
    }
}
```

- Mutation으로 받은 연관값을 이용해 state 변경

## 3. View 만들기, bind
```swift
func bind(reactor: BeersViewReactor) {
    // Action    
    Observable.just(Void())
        .map { Reactor.Action.viewDidLoad }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
    
    // State
    reactor.state
        .map { $0.items }
        .bind(to: beersTableView.rx.items(
            cellIdentifier: BeersTableViewCell.identifier,
            cellType: BeersTableViewCell.self)) { row, item, cell in
                cell.configure(with: item)
            }.disposed(by: disposeBag)
}
```

1. 시작시 Action의 viewdDidLoad 실행
2. State의 items를 beersTableView에 바인딩