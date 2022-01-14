# UI Test

목차
1. UI Test Target 추가
2. Record
3. 테스트

---

## 1. UI Test Target 추가
- Test navigator에서 +를 눌러 New UI Test Target을 선택한다.
- 이름과 타겟을 설정한다.

```swift
var app: XCUIApplication!
```

- XCUIApplocation 프로퍼티를 추가한다.

```swift
try super.setUpWithError()
continueAfterFailure = false
app = XCUIApplication()
app.launch()
```

- setUpWithError()에 위의 코드를 작성하고 나머지 메서드는 삭제한다.

```swift
func testGameStyleSwitch() {

}
```

---

## 2. Record

- 위의 메서드를 추가하고 에디터 밑부분의 빨간 녹화 버튼을 누른다.
- 녹화 버튼을 누르고 한 동작들이 코드로 작성된다.

```swift
func testGameStyleSwitch() {
  let app = XCUIApplication()
  app.buttons["Slide"].tap()
  app.staticTexts["Get as close as you can to: "].tap()
}
```

- 위와 같이 추가가 되는데 app은 setUpWithError에서 설정했으니 삭제한다.
- 아직 이벤트를 보내지 않은 상태로 만들기 위해 tap()을 삭제한다.
- 그리고 buttons["Slide"]를 선택해 segmentedControls.buttons["Slide"]로 변경한다.

```swift
app.segmentedControls.buttons["Slide"]
app.segmentedControls.buttons["Type"]
app.staticTexts["Get as close as you can to: "]
app.staticTexts["Guess where the slider is: "]
```

- 같은 방식으로 테스트할 UI를 추가한다.
- 얘네들이 given이 된다.

---

## 3. 테스트

```swift
if slideSegment.isSelected {
  XCTAssertTrue(slideLabel.exists)
  XCTAssertFalse(typeLabel.exists)
  
  typeSegment.tap()
  XCTAssertFalse(slideLabel.exists)
  XCTAssertTrue(typeLabel.exists)
}
else if typeSegment.isSelected {
  XCTAssertFalse(slideLabel.exists)
  XCTAssertTrue(typeLabel.exists)
  
  slideSegment.tap()
  XCTAssertTrue(slideLabel.exists)
  XCTAssertFalse(typeLabel.exists)
}
```

- 각 세그먼트가 선택된 상태에서 다른 세그먼트를 탭하면 어떤 상태가 되는지 확인한다.
- 어떤게 True여야하고 어떤게 False여야하는지 잘 작성해야한다.