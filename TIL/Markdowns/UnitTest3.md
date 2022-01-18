# Unit Test 3

## 목차
1. FIRST
2. Faking Input from Stub
3. Faking an Update to Mock Object

---

## 1. FIRST
- 좋은 유닛테스트를 위한 원칙들이다.

1. Fast: 유닛 테스트는 빨라야한다.
2. Independent/Isolated: 다른 테스트에 종속적이지 않고 상태를 공유하지 않는다.
3. Repeatable: 실행마다 같은 결과를 내야한다.
4. Self-validating: 결과는 항상 실패 또는 성공이어야하고 프로그래머가 로그를 보고 판단하지 않아야한다.
5. Timely: 이상적으로는 프로덕션 코드를 작성 전에 테스트 코드를 작성해야한다.

- 대부분의 앱은 직접 컨트롤할 수 없는 오브젝트인 시스템과 라이브러리등과 상호작용한다.
- 이러한 오브젝트과 상호작용하는 테스트는 느리고 같은 결과가 나오지 않는다. FIRST 2개 위반.
- 대신에 stub에서 fake input을 주거나 mock을 업데이트해서 사용한다.

---

## 2. Faking Input from Stub
- stub : 사전에 정의된 데이터를 보유하고 테스트 중에 사용하는 객체
- Test navigator에서 New Unit Test Class를 만든다.
- 이름을 정하고 저장할 디렉토리와 타겟을 같게 설정해준다.
- setUpWithError(), tearDownWithError()에 초기값 및 설정

```swift
func testStartNewRoundUsesRandomValueFromApiRequest() {
  // given
  // 테스트할 데이터를 가지고 있는 가짜 URLSession을 만든다.
  let stubbedData = "[1]".data(using: .utf8)
  let urlString =
    "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
  let url = URL(string: urlString)!
  let stubbedResponse = HTTPURLResponse(
    url: url,
    statusCode: 200,
    httpVersion: nil,
    headerFields: nil)
  let urlSessionStub = URLSessionStub(
    data: stubbedData,
    response: stubbedResponse,
    error: nil)
  // sut은 가짜 URLSession으로 dataTask를 실행한다.
  sut.urlSession = urlSessionStub
  let promise = expectation(description: "Value Received")
  // when
  sut.startNewRound {
    // then
    // sut의 completion시 fulfill
    XCTAssertEqual(self.sut.targetValue, 1)
    promise.fulfill()
  }
  wait(for: [promise], timeout: 5)
}
```

- URLSessionStub은 예제에서 만들어진거로 사용한다.
- 진짜 통신하는거는 아니고 진짜로 통신해서 받을만한 데이터와 상태코드를 가지도록 가짜 URLSession을 만든거다.
- 실제 URLSession처럼 dataTask라는 이름으로 비동기 메서드를 만들어놔서 통신이 제대로 되는지 테스트가 가능하다.

---

## 3. Faking an Update to Mock Object
- Mock은 stub처럼 가짜 데이터를 가지고 있지만 어떤 메서드가 호출됐는지 아는것도 가능하다.
- UserDefaults에 값을 저장하는 테스트를 한다.

```swift
class MockUserDefaults: UserDefaults {
  var gameStyleChanged = 0
  override func set(_ value: Int, forKey defaultName: String) {
    if defaultName == "gameStyle" {
      gameStyleChanged += 1
    }
  }
}
```

- Mock Object를 만든다. gameStyleChanged의 값에 따라서 set이 얼마나 호출 됐는지 알 수 있다.
- set을 override 했으므로 실제로 값을 저장시키지 않고 테스트한다.

```swift
var sut: ViewController!
var mockUserDefault: MockUserDefaults!
```

- sut과 mockUserDefault를 만든다.

```swift
func testGameStyleCanBeChanged() {
  // given
  let segmentedControl = UISegmentedControl()
  segmentedControl.addTarget(sut, action: #selector(ViewController.chooseGameStyle(_:)), for: .valueChanged)
  
  // when
  XCTAssertEqual(mockUserDefault.gameStyleChanged, 0, "0 before sendAction")
  segmentedControl.sendActions(for: .valueChanged)
  
  // then
  XCTAssertEqual(mockUserDefault.gameStyleChanged, 1, "UserDefault did not set")
  
}
```

- segmentedControl으로 sendActions를해서 UserDefault의 set이 실행되는지 확인한다.
- gameStyleChanged 같이 확인하는 값은 Bool보다는 Int로 하는것이 좋다. 실행 횟수를 정확히 알 수 있기 때문이다.