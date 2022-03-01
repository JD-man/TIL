# ReactorKit

1. 의의
2. View
3. Reactor
4. 예제
[]

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

