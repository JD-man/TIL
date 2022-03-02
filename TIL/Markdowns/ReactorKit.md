# ReactorKit

1. 의의
2. View
3. Reactor
4. 예제

---

## 1. 의의
- View는 action만, Reactor는 State만 방출하는 단방향 반응형 앱 제작 프레임워크

--

## 2. View
- Data를 보여준다.
- View Controller, Cell 모두 view로 다룬다.
- User Input은 action stream에 바인딩
- state는 UI Components에 바인딩

### protocol View 
- view로 사용될 클래스에 View Protocol을 채택한다.
- reactor 프로퍼티에 사용할 reactor를 inject한다.

### func Bind
- action과 state를 바인딩하기위해 사용된다.
- reactor 프로퍼티에 변화가 있으면 bind 메서드가 호출된다.

---

## 3. Reactor
- view state를 관리하는 UI에 독립된 layer
- view로부터 control flow가 분리됨.
- 모든 view는 대응되는 reactor를 가지고 있으며 logic을 위임한다.
- reactor는 view에 독립적이다.

### protocol Reactor
- reactor로 사용될 클래스에 Reactor protocol 채택
- Action, Mutation, State, initialState가 필요하다.

### mutate()
- Action을 받아 Observable`<Mutation>`을 리턴
- API 호출과 같은 side effect는 여기에서 수행된다.

### reduce()
- Mutation을 받아 State를 리턴
- 동기적으로 State를 리턴하므로 side effect가 수행되면 안된다.

### transform()
- stream을 변환시켜준다.
- 다른 observable과 결합하는데 사용된다.

---

## 4. 예제

### 1. View -> Action
```swift
func bind(reactor: SomeReactor) {
    // Action 1.
    searchController.searchBar.rx.text
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Reactor.Action.updateQuery($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    // Action 2.
    tableView.rx.contentOffset
      .filter { [weak self] offset in
        guard let `self` = self else { return false }
        guard self.tableView.frame.height > 0 else { return false }
        return offset.y + self.tableView.frame.height >= self.tableView.contentSize.height - 100
      }
      .map { _ in Reactor.Action.loadNextPage }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
}

```

- Action : Input -> Reactor.Action.someAction -> bind to reactor.action
- State : State -> (map) repos -> bind to tableview items

### Reactor 구성요소
```swift
  enum Action {
    case updateQuery(String?)
    case loadNextPage
  }

  enum Mutation {
    case setQuery(String?)
    case setRepos([String], nextPage: Int?)
    case appendRepos([String], nextPage: Int?)
    case setLoadingNextPage(Bool)
  }

  struct State {
    var query: String?
    var repos: [String] = []
    var nextPage: Int?
    var isLoadingNextPage: Bool = false
  }
```

- Action: SearchBar Text, TableView contentOffset에 대응되는 Action 2개
- Mutation: Action이 왔을때 State를 변화시킬 케이스
- State: 상태들의 구조체

### Action -> Mutation
```swift
func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .updateQuery(query):
      return Observable.concat([        
        Observable.just(Mutation.setQuery(query)),
        self.search(query: query, page: 1)          
          .take(until: self.action.filter(Action.isUpdateQueryAction))
          .map { Mutation.setRepos($0, nextPage: $1) },
      ])
}
```

- 실행순서를 위해 concat 사용
- updateQuery Action은 setQuery와 setRepos Mutation을 리턴


### State 변화
```swift
func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    case let .setQuery(query):
      var newState = state
      newState.query = query
      return newState

    case let .setRepos(repos, nextPage):
      var newState = state
      newState.repos = repos
      newState.nextPage = nextPage
      return newState
}
```

- setQuery: state의 query를 변화시킴
- setRepos: state의 repos와 nextPage를 변화시킴

### View, State bind
```swift
//...

func bind(reactor: someReactor) {
    reactor.state.map { $0.repos }
      .bind(to: tableView.rx.items(cellIdentifier: "cell")) { indexPath, repo, cell in
        cell.textLabel?.text = repo
      }
      .disposed(by: disposeBag)
}
//...
```

### 예제의 데이터 흐름

- 서치바 텍스트 -> updateQuery 액션 -> setQuery, setRepos Mutation -> reduce에 정의된대로 state 변화 -> 테이블뷰