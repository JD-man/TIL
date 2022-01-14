# Test Performance, Code Coverage

## 목차
1. Test Performance
2. Code Coverage

---


## 1. Test Performance

- measure(metrics:block:)을 이용해서 성능 테스트를 한다.
- Metric이라고 작성하면 머머있는지 다 나옴.
- 문서에 의하면 코드 블록 10번을 가져와서 평균 실행 시간과 표준 편차를 수집한다고 한다.

```swift
func testScoreIsComputedPerformance() {
  measure(
    metrics: [
      XCTClockMetric(),
      XCTCPUMetric(),
      XCTStorageMetric(),
      XCTMemoryMetric()
    ]) {
      sut.check(guess: 100)
    }
}
```
- 테스트를 실행하면 Baseline을 설정하라고 나온다.
- measure 옆에 있는 버튼을 누르면 성능 결과가 나오는데 거기서 Baseline 설정가능.

---

## 2. Code Coverage
- Product -> Scheme -> Edit Scheme -> Test -> Code Coverage
- 여기에서 Gather coverage for 체크
- cmd+U로 모든 테스트 실행후에 cmd+9 눌러서 Report navigator 확인
- Coverage 클릭 후 각 스위프트 파일마다 Coverage 확인 가능 (옆에 있는 화살표 클릭)

### 100% Code Coverage에 대해서
- 어떤 주장은 마지막 10~15%는 테스트할 필요가 없다고 한다.
- 하지만 다른 주장은 그 10~15%는 테스트하기 힘들기 때문에 중요하다고 한다.
- 구글은 테스트할 수 없는 코드가 깊게 자리잡은 디자인 문제의 신호라고 한다.