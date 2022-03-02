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

---

## 2. Reactor 만들기
### 구성요소
```swift
enum Action {
    case updateBeers
}

enum Mutation {
    case setBeersItem(items: [BeersItemModel], nextPage: Int)
}

struct State {
    var items: [BeersItemModel] = []
    var nextPage: Int = 0
}
```

- Action: viewDidLoad시 API 호출
- Mutation: State의 items와 nextPage 업데이트
- State: 테이블뷰에 사용할 items와 Pagination을 위한 nextPage


### mutate
```swift
// Action -> Mutation
func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateBeers:        
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

---

## 3. View 만들기, bind
```swift
func bind(reactor: BeersViewReactor) {
    // Action    
    Observable.just(Void())
        .map { Reactor.Action.updateBeers }
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

<table align="center">
<tr>
<th colspan="2"> Result </th>
</tr>
<tr>
<td>
<p align="center">
<video src= https://user-images.githubusercontent.com/62129500/156398219-53d0dd9d-5fa8-4956-8ac5-cb5a8c396c79.mp4 width = 70%>
</p>
</td>  
</tr>
</table>

---

## 4. Pagination

### View, bind 추가
```swift
func bind(reactor: BeersViewReactor) {
    // ...

    // Action 2. tableview scrolling -> pagination
    beersTableView.rx.contentOffset
        .filter { [weak self] in
            guard let self = self else { return false }
            // 시작하자마자 pagination 되는 것을 방지
            guard self.beersTableView.frame.height > 0 else { return false }
            return $0.y + self.beersTableView.frame.height > self.beersTableView.contentSize.height - 100
        }.map { _ in Reactor.Action.pagination }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)

    // ...
}
```

- beersTableView의 contenOffset을 이용
- offset + height > contentSize.height - 100인 경우에만 pagination Action 실행

### Reactor 구성요소 추가 
```swift
enum Action {
    // ...
    case pagination
}

enum Mutation {
    // ...
    case addBeersItem(items: [BeersItemModel], nextPage: Int)
    case setLoadingStatus(status: Bool)
}

struct State {
    // ...
    var isLoading: Bool = false
}
```

- pagination Action 추가
- 추가로 가져오는 items를 추가하는 Mutation, 중복호출을 방지하는 isLoading 변경하는 Mutation 추가
- isLoading == false인 state에서만 pagination 가능

### Reactor mutate 케이스 추가
```swift
case .pagination:
    guard self.currentState.isLoading == false else { return Observable.empty() }
    return Observable.concat([
        Observable.just(Mutation.setLoadingStatus(status: true)),
        getBeers(page: currentState.nextPage)
            .map { Mutation.addBeersItem(items: $0.0, nextPage: $0.1) },
        Observable.just(Mutation.setLoadingStatus(status: false)),
        ])
```

- concat을 이용해 로딩중 상태변경 -> 데이터 추가 -> 로딩완료 상태변경 순서대로 실행
- getBeers의 observable은 반드시 complete이 되어야 한다.

### Reactor reduce 케이스 추가
```swift
case .addBeersItem(let items, let nextPage):
    var newState = state
    newState.items.append(contentsOf: items)
    newState.nextPage = nextPage
    return newState
case .setLoadingStatus(let status):
    var newState = state
    newState.isLoading = status
    return newState
```
###

## 5. 결과
<table align="center">
<tr>
<th colspan="2"> Result </th>
</tr>
<tr>
<td>
<p align="center">
<video src= https://user-images.githubusercontent.com/62129500/156398497-2ee7dc61-e361-4b5a-9591-f3f5bddf5248.mp4 width = 70%>
</p>
</td>  
</tr>
</table>
        
