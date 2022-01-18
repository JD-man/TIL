# Subscript

- Array에 [0]써서 첫번째 값에 접근하듯이 만들어준다.
- 클래스, 구조체, 열거형 등에 직접 정의해서 사용가능.
- Computed Property를 사용해서 구현

## 기존 자료형에 사용가능
- String에 적용해보기
```swift
extension String {
    subscript(idx: Int) -> String? {
        // [-1]이면 거꾸로해서 반환
        if idx == -1 {
            return String(self.reversed())
        }
        // 0부터는 해당 index 값 반환
        guard idx > 0, idx < count else {
            return nil
        }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}

let str = "Hello World"
print(str[-1])
print(str[0])
print(str[2])
print(str[7])
print(str[10])
print(str[11])
print(str[199])

/*
Optional("dlroW olleH")
nil
Optional("l")
Optional("o")
Optional("d")
nil
nil
*/
```

## 커스텀 구조체에 사용하기
```swift
struct UserPhone {
    var numbers = ["11111", "22222", "33333"]
    subscript(idx: Int) -> String? {
        get {
            guard (0 ..< numbers.count).contains(idx) else {
                return nil
            }
            return numbers[idx]
        }
        set {
            guard (0 ..< numbers.count).contains(idx) else {
                return
            }
            self.numbers[idx] = newValue ?? ""
        
    }

var value = UserPhone()
print(value[0])
value[0] = "변경"
print(value[0])

/*
Optional("11111")
Optional("변경")
*/
```