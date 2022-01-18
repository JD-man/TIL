# Copy On Write

- Collection Type 등에서 원본을 공유하다가 수정이 일어날 경우 실제로 복사하는 작업
- 복사가 일어나기 전 값에 대한 메모리를 공유하기 때문에 성능 향상에 이점이 있다.


## String의 경우
- 구조체인 String은 기본적으로 복사가 일어난다.

```swift
var nickname = "JD"
print(address(of: &nickname)) // 0x16f96bd48

var nicknameByFamily = nickname
print(address(of: &nicknameByFamily)) // 0x16f96bd38. 값복사가 되는 시기부터 주소가 다르다.


nicknameByFamily = "조동"
print(address(of: &nicknameByFamily)) // 0x16f96bd38. 수정이 일어나도 새 변수의 주소는 그대로다.

print(nickname, nicknameByFamily) // JD 조동
```

## Array의 경우
- Array는 구조체이지만 Copy On Write로 인해 String과는 다르게 동작한다.
```swift
// Array도 구조체
var array = Array(repeating: 100, count: 100)
print(address(of: &array)) // 0x151069b70

var newArray = array
print(address(of: &newArray)) // 0x151069b70. 원본 주소와 동일하다!!
newArray[0] = 0
print(address(of: &newArray)) // 0x151069eb0. 새 변수가 수정되니 주소가 변경된다!!

print(array[0], newArray[0]) // 100 0. 참조타입은 아니므로 값은 다르다!!
```

- Collection Type의 경우 컴파일 시점에 데이터의 크기를 알기 힘들어서 대체적으로 Heap에 저장된다!!