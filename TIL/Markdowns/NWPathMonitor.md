# NWPathMonitor

- 네트워크 연결 상태, 변경을 감지

```swift
// 네트워크 변경 감지 클래스
let networkMonitor = NWPathMonitor()

func networkMonitorConfig() {
    networkMonitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            print("Network Conneted")
                
            if path.usesInterfaceType(.cellular) {
                print("using cellular data")
            }
            else if path.usesInterfaceType(.wifi) {
                print("using wifi")
            }
            else {
                print("others")
            }
        }
        else {
            print("Network Disconneted")
        }
    }
        
    networkMonitor.start(queue: DispatchQueue.global())
}
```