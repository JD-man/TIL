# Unit Test 1
- [참고 튜토리얼](https://www.raywenderlich.com/21020457-ios-unit-testing-and-ui-testing-tutorial)

## 목차
1. 목적
2. 사용예제
3. 테스트할 내용
4. Unit Test Bundle 만들기
5. 초기화 및 설정
6. Test Code 작성
7. 테스트 코드로 버그찾기

---

## 1. 목적
- 앱모델과 비동기 메서드에 대한 Xcode Test Navigator 사용
- 가짜 상호작용 주기
- UI Performance 테스트
- code coverage tool 사용

---

## 2. 사용예제
- 위 참고 튜토리얼의 BullsEyeGame 프로젝트(가입해야 받을 수 있음)

---

## 3. 테스트할 내용
- 아래 항목을 테스트할 수 있어야한다.
1. Model - Controller Interaction
2. UI Workflows
3. Boundary Conditions
4. Bug Fixes
5. FIRST

---

## 4. Unit Test Bundle 만들기
- 프로젝트롤 열고 cmd+6 누르면 Test navigator가 나옴
- 왼쪽맨하단에 +버튼을 눌러서 New Unit Test Target을 만든다.
- 기본 이름을 그냥 사용한다.
- Test bundle이 만들어지면 BullsEyeTests를 눌러서 에디터에 띄운다.
- XCTest는 기본으로 import.
- setUpWithError(), tearDownWithError(), testExample(), testPerformanceExample() 4개의 메서드가 있다.
- 이 튜토리얼에서는 마지막 2개 함수는 안쓴다고 삭제함.
---

## 5. 테스트 전 초기화 및 설정

```swift
@testable import BullsEye
``` 
- 테스트하려는 모듈을 import한다.
- Internal 타입에 대해서 유닛테스트가 가능하게 해준다.

```swift
var sut: BullsEyeGame!
```
- BullsEyeGame는 이 프로젝트의 클래스 중 하나로 게임 로직이 들어있다.
- sut는 System Under Test라는 뜻이다.

```swift
try super.setUpWithError()
sut = BullsEyeGame()
```
- setUpWithError()의 내용을 위와 같이 변경한다.
- setUpWithError()의 코드는 각 테스트 메서드를 호출하기 전에 실행된다. 각 테스트마다의 초기화코드.
- 모든 테스트는 BullsEyeGame의 프로퍼티와 메서드에 접근 가능해진다.

```swift
sut = nil
try super.tearDownWithError()
```
- tearDownWithError()의 내용은 위와 같이 변경한다.
- tearDownWithError()의 코드는 각 테스트가 이루어진 후에 실행된다.
- 테스트가 끝나고 sut은 release하는 것이 좋다고 한다. 테스트마다 새로운 인스턴스를 받는다는 것을 명확하게 해줘서.

---

## 6. Test 코드 작성하기
```swift
func testScoreIsComputedWhenGuessIsHigherThanTarget() {
  // given
  let guess = sut.targetValue + 5

  // when
  sut.check(guess: guess)

  // then
  XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
}
```

- 테스트 메서드의 이름은 test로 시작해야하고 그 뒤에 무슨 테스트하는지로 만든다.
- 테스트 코드는 given, when, then으로 나누어서 작성하는 것이 좋다.
1. given: 필요한 값들을 초기화.
2. when: 테스트를 위해 코드가 실행되는곳
3. then: XCTAssert를 이용해 테스트 결과가 나오는 곳

- BullsEyeGame의 targetValue 초기값은 50이다.
- guess는 55다.
- check는 scoreRound를 100 - (guess - targetValue)로 만든다.
- 100 - 5라서 95가 나오고 위 테스트는 통과된다.

---

## 7. 테스트로 버그찾기
```swift
// given
let guess = sut.targetValue - 5
// when
sut.check(guess: guess)
// then
XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
```

- guess = 45
- check = 100 - (45 - 50) = 105
- 만약 guess와 targetValue의 차이가 단순히 5일때라고 생각해서 코드를 짰다면??
- 이 테스트 코드에 걸린다.
- Breakpoint Navigator (cmd+8)에 좌측맨하단 +버튼으로 Test Failure Breakpoint를 추가해서 실패상황 확인 가능
- 더 정확히 확인하기 위해서 swift 파일 내부에 Breakpoint를 설정하면 좋다.

---