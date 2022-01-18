# Concurrency

## 목차
1. Concurrency
2. Asynchronous Functions
3. Asynchroouns Sequences
4. Parallel
5. Task, Task Groups
6. Cancel
7. Actors

---

## 1. Concurrency
### 1) 의의
- Swift는 asynchronous, parallel 코드를 지원한다.
- 아래와 같은 기존의 completion handler의 복잡한 코드를 대체할 수 있다.

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```

### 2) Asynchronous code
- 멈췄다가 재개할 수 있는 코드.
- 네트워크와 같은 시간이 걸리는 작업을 계속 하는 중에도 짧은 시간이 걸리는 UI 업데이트가 진행된다.

### 3) Parallel code
- 동시에 여러개가 실행되는 코드

### 4) parallel and asynchronous
- 한번에 여러개의 작업을 할 수 있게 해준다.
- memory-safe하며, 외부 시스템을 기다리는 동안 작업을 중단시킬 수 있다.

---

## 2. Asynchronous Function
### 1) 정의
- Asynchronous Function 또는 Method는 잠시 중단될 수 있다.
- 완료까지 실행되고 에러를 던지거나 리턴하지 않는 synchronous function과 다르다.
- 위의 세가지 모두 가능하기도 하지만 무언가를 기다리기 위해 잠시 중단할 수 있다.
- method 안의 body에 어디서 멈출지 표시할 수 있다.

### 2) 예시
```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ...
    return result
}
```

- 파라미터 뒤에 async를 사용하여 asynnchronous function임을 표시한다.
- 에러를 던진다면 async throws 순으로 작성한다.

```swift
let photoNAmes = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

- 위에서 작성한 completion handler가 중복된 코드는 위와같이 변경된다.
- async function 앞에 await을 작성해서 사용한다.
- async function을 호출하면 리턴될때까지 실행이 중단된다.
- asnyc function 내부에서의 실행 흐름은 내부의 다른 async function이 호출되면 중단된다.
- 상대적으로 시간이 걸리는 listPhotos와 downloadPhotos를 async로 만들어 기다리는 동안 코드를 멈추고 앱의 나머지를 실행하게 한다.

### 3) Yielding the Thread
- await이 사용된다는것은 async function이 리턴될때까지 실행이 잠시 멈출수도 있다는 것이다.
- 그 코드를 실행하고 있는 스레드에 대신 다른 코드가 실행된다.
- 따라서 async function은 프로그램의 특정한 곳에서 호출해야한다.
1. body of async function, method or property
2. static main() of a structure, class or enumeration marked with @main
3. detached child task

---

## 3. Asynchronous Sequences
### 1) 의의
- 이전 챕터의 listPhotos(inGallery:)는 모든 리스트가 준비됐을때 리턴한다.
- Asynchrounous Sequences는 하나의 요소에 대한 것이다.

### 2) 예시
```swift
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

- 일반적인 for-in 루프 대신 for 다음 await을 사용한다.
- 다음 요소가 사용이 가능해질때 까지 모든 반복의 시작마다 실행이 중단된다.

### 3) AsyncSequence Protocol for Custom Type
- AsyncSequence 프로토콜을 사용해 for-await-in 루프가 사용되게 만들 수 있다.

---

## 4. Parallel
### 1) 문제의 소재
- await은 한번에 코드의 한 부분만 실행된다
```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```
- 위의 코드에서 secondPhoto는 firstPhoto가 완료되어야 시작된다.
- 이런 다운로드는 한번에 하나씩이 아닌 같이 진행되야한다.

### 2) 해결방법
```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```
- 위에 상수를 정의할때는 async를 맨 앞에 작성하고, 상수를 사용할때 await을 작성한다!
- 위의 예시에서 시스템 리소스만 충분하다면 동시에 다운로드가 진행된다.
- 나머지 코드 실행을 위해 중단되야하는 경우가 아니므로 await을 사용하지 않는다.
- 하지만 show가 실행되기 전 photos가 정의될때는 중단될 필요가 있다. 그래서 await을 사용한다.

### 3) 차이점
- async function의 결과가 따라오는 코드에 사용되는 경우 바로 await을 사용한다. (sequentially)
- async function의 결과가 따라오는 코드에 사용되지 않는다면 async-let을 사용한다. (parallel)
- 두가지 경우 모두 async function이 리턴하기 전까지의 중단 포인트가 필요한 부분에 await을 사용한다.
- 둘을 섞어서 사용가능하다.

---

## 5. Tasks, Tasks Groups
### 1) 정의
- Task: 프로그램의 일부로서 비동기적으로 실행되는 작업의 단위
- 모든 비동기 코드는 task로서 실행된다.
- async-let 구문은 child task를 만든다.
- task group을 만들 수 있으며 child task를 task group에 추가할 수 있다.

### 2) Structured Concurrency
- Task들은 Hierarchy에 나열된다.
- 같은 task group의 task들은 같은 부모 task를 가지며 각 task는 child task를 가질 수 있다.
- 이러한 task와 task group의 명확한 관계를 Structured Concurrency라고 부른다.
```swift
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.async { await downloadPhoto(named: name) }
    }
}
```

### 3) Unstructured Concurrency
- Unstructured Task는 parent group이 없다.
- Task.init(priority:operation:)을 이용해서 Unstructured task를 실행 current actor에 실행한다.
- current actor의 일부분이 아닌 경우 Task.detached(priority:operation:)을 사용한다.
- 두가지 경우 모두 다 task handle을 리턴한다.

```swift
let newPhoto = // ...
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value
```

---

## 6. Cancel
- 모든 task는 실행시점에서 자신이 취소가 됐는지 체크한다.
- 다음 경우에 취소된다.
1. throwing CancellationError
2. returning nil or empty collection
3. returning the partially completed work

- Task.checkCancellation(), Task.isCancelled로 확인
- Task.cancel()로 취소. 취소할 수 없거나 이미 취소될 수 있는 지점을 넘은 경우는 취소 불가.
- 예를 들면, 갤러리로부터 사진을 받는 task는 일부만 다운로드 된 경우나 네트워크 연결이 끊겼을때 삭제된다.

---

## 7. Actors
### 1) 정의
- 참조타입으로서 클래스와 비교된다.
- 한번에 하나의 task만 가진다.

### 2) 예시
```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    // private(set): 외부에서는 읽기만 가능, 내부에서만 쓰기가 가능하게 함
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
```

- 클래스처럼 actor를 사용해서 만든다.
- max 프로퍼티는 actor 내부의 코드로만 업데이트할 수 있다. (private(set))

```swift
let logger = TemperatureLogger(label: "Outdoors.", measurement: 25)
Task(priority: .medium) {
    print(await logger.max)
} // 25
```

- actor의 프로퍼티에 접근할때는 await을 사용한다.
- actor는 한번에 하나의 task만 허용하기 때문에, 다른 task가 logger에 접근하고있다면, 이 코드는 중단된다.

```swift
extension TemperatureLogger {
    func update(with measurement: Int) {
        measuremetns.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
```
- actor 내부에서 접근할때는 await을 사용하지 않아도 된다.

### 3) actor가 한번에 하나의 task만 허용하는 이유.
- 위 예시의 경우 measurements array에 값이 추가되고 max가 업데이트 되기 전에 다른 task가 max 값을 읽을 수도 있다.
- 이러한 부정확한 상태를 방지하기 위해서 하나의 Task에서만 사용이 가능하다.

### 4) actor isolation
- await 없이 logger.max에 접근할 수 없다.
- acotr의 프로퍼티들은 actor의 isolated local state기 때문이다.
- Swift는 actor의 local state에 actor 내부의 코드만 접근할 수 있게 해준다.
- 이것을 actor isolation이라고 부른다.
