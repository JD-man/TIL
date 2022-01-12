# Unit Test 2

## 목차
1. 비동기 작업 테스트 준비
2. 비동기 테스트 코드 작성
3. 오류 테스트
4. 오류 테스트 수정
5. 테스트 환경

---

## 1. 비동기 작업 테스트 준비
- 비동기 메서드를 테스트하기 위해서는 XCTestExpectation을 사용한다.
- 비동기 테스트는 보통 느리기 때문에 빠른 테스트와 분리해놓는 것이 좋다.
- 그래서 New unit test target으로 새로운 테스트 타겟을 만든다.

```swift
var sut: URLSession!

override func setUpWithError() throws {
  // Put setup code here. This method is called before the invocation of each test method in the class.
  try super.setUpWithError()
  sut = URLSession(configuration: .default)
}

override func tearDownWithError() throws {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  sut = nil
  try super.tearDownWithError()
}
```

- URLSession을 사용하므로 sut는 URLSession으로 만든다. default configuration을 사용함.

---

## 2. 비동기 테스트 코드 작성
```swift
func testValidApiCallGetsHTTPStatusCode200() throws {
  // given
  // 초기값 설정
  let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
  let url = URL(string: urlString)!
  
  // expectation: XCTestExpectation을 반환. description에는 통과되는 상황을 적는다.
  let promise = expectation(description: "Status code: 200")
  
  // when
  let dataTask = sut.dataTask(with: url) { _, response, error in
    // then
    if let error = error {
      XCTFail("Error: \(error.localizedDescription)")
      return
    } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
      if statusCode == 200 {
        // 통과시 실행될 비동기 completion 클로저에서 성공했다고 호출한다.
        promise.fulfill()
      } else {
        XCTFail("Status code: \(statusCode)")
      }
    }
  }
  dataTask.resume()
  
  // 모든 expectation이 통과되거나 timeout시까지 테스트를 계속 진행한다.
  wait(for: [promise], timeout: 5)
}
```

---

## 3. 오류 테스트 

```swift
let wrongString = "http://www.randomnumberapi.com/test"
let url = URL(string: wrongString)!
```

- 위의 코드에서 url만 오류가 나도록 수정한다.

```
Test Suite 'BullsEyeSlowTests.xctest' started at 2022-01-12 21:39:46.677
Test Suite 'BullsEyeSlowTests' started at 2022-01-12 21:39:46.677
Test Case '-[BullsEyeSlowTests.BullsEyeSlowTests testValidApiCallGetsHTTPStatusCode200]' started.
/Users/jdman/Documents/BullsEye/starter/BullsEye/BullsEyeSlowTests/BullsEyeSlowTests.swift:71: error: -[BullsEyeSlowTests.BullsEyeSlowTests testValidApiCallGetsHTTPStatusCode200] : failed - Status code: 404
/Users/jdman/Documents/BullsEye/starter/BullsEye/BullsEyeSlowTests/BullsEyeSlowTests.swift:77: error: -[BullsEyeSlowTests.BullsEyeSlowTests testValidApiCallGetsHTTPStatusCode200] : Asynchronous wait failed: Exceeded timeout of 5 seconds, with unfulfilled expectations: "Status code: 200".
Test Case '-[BullsEyeSlowTests.BullsEyeSlowTests testValidApiCallGetsHTTPStatusCode200]' failed (5.008 seconds).
Test Suite 'BullsEyeSlowTests' failed at 2022-01-12 21:39:51.685.
	 Executed 1 test, with 2 failures (0 unexpected) in 5.008 (5.008) seconds
Test Suite 'BullsEyeSlowTests.xctest' failed at 2022-01-12 21:39:51.686.
	 Executed 1 test, with 2 failures (0 unexpected) in 5.008 (5.009) seconds
Test Suite 'Selected tests' failed at 2022-01-12 21:39:51.686.
	 Executed 1 test, with 2 failures (0 unexpected) in 5.008 (5.010) seconds
```

- 위와 같이 결과가 나오는데 테스트는 1개인데 failure는 2개가 나온다.
- 하나는 404 에러고 다른 하나는 wait에서 설정한 timeout 에러다.
- wait은 모든 테스트가 **통과**되거나 **timeout**시까지 테스트를 계속 돌리기 때문에  
  테스트가 실패해도 timeout까지 기다리는 것임.

---

## 4. 오류 테스트 수정

- 이전의 테스트 코드에서는 실제 앱에서 동작하는 방식대로 작성했다.
- 그러다보니 통신에 성공했을때만 fulfill이 되고 실패하면 timeout을 기다리게된다.

```swift
func testApiCallCompletes() throws {
  // given
  let urlString = "http://www.randomnumberapi.com/test"
  let url = URL(string: urlString)!
  let promise = expectation(description: "Completion handler invoked")
  var statusCode: Int?
  var responseError: Error?
  // when
  let dataTask = sut.dataTask(with: url) { _, response, error in
    statusCode = (response as? HTTPURLResponse)?.statusCode
    responseError = error
    promise.fulfill()
  }
  dataTask.resume()
  wait(for: [promise], timeout: 5)
  // then
  XCTAssertNil(responseError)
  XCTAssertEqual(statusCode, 200)
}
``` 

- 조금 다르게 completion에서 statusCode와 error을 받아오는 과정 자체를 통신성공이라고 가정한다.
- 통신에 성공하거나 에러가있거나 어쨌든 completion은 호출되므로 promise.fulfill()은 항상 실행된다.
- 따라서 promise가 성공할때까지 기다리는 비동기 과정을 거치고 나서 then에서 결과를 테스트한다.

```
Test Suite 'Selected tests' started at 2022-01-12 22:06:50.351
Test Suite 'BullsEyeSlowTests.xctest' started at 2022-01-12 22:06:50.352
Test Suite 'BullsEyeSlowTests' started at 2022-01-12 22:06:50.352
Test Case '-[BullsEyeSlowTests.BullsEyeSlowTests testApiCallCompletes]' started.
/Users/jdman/Documents/BullsEye/starter/BullsEye/BullsEyeSlowTests/BullsEyeSlowTests.swift:99: error: -[BullsEyeSlowTests.BullsEyeSlowTests testApiCallCompletes] : XCTAssertEqual failed: ("Optional(404)") is not equal to ("Optional(200)")
Test Case '-[BullsEyeSlowTests.BullsEyeSlowTests testApiCallCompletes]' failed (0.505 seconds).
Test Suite 'BullsEyeSlowTests' failed at 2022-01-12 22:06:50.857.
	 Executed 1 test, with 1 failure (0 unexpected) in 0.505 (0.505) seconds
Test Suite 'BullsEyeSlowTests.xctest' failed at 2022-01-12 22:06:50.858.
	 Executed 1 test, with 1 failure (0 unexpected) in 0.505 (0.506) seconds
Test Suite 'Selected tests' failed at 2022-01-12 22:06:50.858.
	 Executed 1 test, with 1 failure (0 unexpected) in 0.505 (0.507) seconds
```

- XCTAssertEqual에서 statusCode가 404라는 실패 결과만 나온다.

---

## 5. 테스트 환경

- 이런 네트워크를 이용하는 비동기 테스트는 인터넷에 연결을 해놨어야 가능하다.
- 이런 테스트 환경에 의한 실패를 위해서 XCTSkip을 사용한다.

```swift
try XCTSkipUnless(networkMonitor.isReachable,
                    "Network connectivity needed for this test")
```