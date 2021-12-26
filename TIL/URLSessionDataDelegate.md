# URLSessionDataDelegate

## 목차
1. 의의
2. Session 생성
3. URLSessionDataDelegate
4. Invalidate Session

---

## 1. 의의
- 기본적인 요청의 경우 SharedSession, dataTask, completionHandler로 구현가능.
- 하지만 데이터가 크거나 데이터를 받아오는 과정에서 뭔가 처리할게 필요하다면 completion handler로는 부족하다.
- 그럴땐 default Session을 생성하는것과 같이 shared를 제외한 다른 Session을 사용하는 것이 좋다.
- 데이터를 받을 때도 데이터의 크기를 고려해 백그라운드 다운로드도 지원하는 Download Task가 더 적합하다.

---

## 2. Session 생성
```swift
var session: URLSession!

// 바로 생성
session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)

// URLSessionConfiguration
let configuration = URLSessionConfiguration.default
configuration.allowCellularAccess = false
configuration.timeoutIntervalForRequest = 5

session = URLSession(configuration: configuration)
```

- 바로 생성하거나 URLSessionConfiguration으로 세부 설정을 하고 만들어도 된다.

---

## 3. URLSessionDataDelegate
### 1) didReceive response
- 서버로부터 **최초로** 응답을 받았을 때 호출된다.

```swift
func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
    if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
        print(response)        
        return .allow // didRecieve data 실행
    }
    else {
        return .cancel // didCompleteWithError 실행
    }
}
```
- 헤더에 있는 값을 읽어서 사용할 수 있다.
- 이 이후에 didReceive data로 넘어가 Task를 계속 진행할지, didCompleteWithError로 넘어가 Task를 끝낼지 결정할 수 있다.

### 2) didReceive data
- 서버에서 데이터를 받을 때마다 호출된다.
- 크기가 큰 사진의 경우 buffer를 만드는 등의 작업을 할 수 있다.
```swift
func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    //print(data)
    buffer?.append(data)
}
```

### 3) didCompleteWithError
- 응답이 완료되면 호출된다.
- 에러가 있을수도있고 없을수도있다.
- 에러가 없으면 데이터를 성공적으로 받은거임.
- 에러에 대한 옵셔널 바인딩 분기처리로 대응한다.
```swift
func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if let error = error {
        print("오류 발생", error)
    }
    else {
        print("성공")
        // Buffer가 모두 채워졌을때 이미지로 변환
        guard let buffer = buffer else {
            print("buffer error")
            return
        }
        
        let image = UIImage(data: buffer)
        imageView.image = image
    }
}
```
---

## 4. Invalidate Session
- URLSession을 사용하면 리소스를 정리해야한다.
- URLSession과 delegate는 강한 참조로 연결되기 때문이다.
- deinit이나 viewWillDisappear 같이 화면이 사라지는 시점에 메모리 정리가 필요하다.

```swift
session.invalidateAndCancel()
session.finishTaskAndInvalidate()
```

- invalidateAndCancel : Task, 리소스 즉시정리.
- finishTaskAndInvalidate : 실행중인 Task를 완료하고 리소스 정리.
