# CLLocation

## CLLocation을 사용해 사용자의 위치 정보 얻는 과정
1. Info.plist -> Privacy - Location 관련 설정
2. CLLocationManager 인스턴스 생성
3. CLLocationManagerDelegate 설정
- 디바이스의 위치 권한 설정 확인  
  CLAuthorizationStatus, CLLocationManager.locationServicesEnabled()

- 어플의 위치 권한 설정 확인  
  switch CLAuthorizationStatus

- 정확한 위치 사용 확인  
  CLLocationManager 인스턴스의 accuracyAuthorization

- didUpdateLocations  
  locations.last.coordinate, stopUpdatingLocation

- locationManagerDidChangeAuthorization  
  디바이스위 위치 권한 확인

---

## - Delegate 설정 이후 과정
### 디바이스의 위치 권한 설정
- CLAuthorizationStatus : 버전에 따라 설정
- CLLocationManager.locationServicesEnabled() : 디바이스 위치 권한 있다면 앱 위치 권한 확인

```swift
func checkUserLocationServiceAuthorization() {
        
    let authStatus: CLAuthorizationStatus
        
    if #available(iOS 14.0, *) {
        authStatus = locationManager.authorizationStatus // iOS14 이상
    }
    else {
        authStatus = CLLocationManager.authorizationStatus() // iOS14 미만
    }
    
    // iOS 시스템 위치 서비스 확인
    if CLLocationManager.locationServicesEnabled() {
        // 권한 상태 확인 및 권한 (8번 메서드 실행)
        checkCurrentLocationAuthorization(authStatus: authStatus)
    }
    else {
        print("alert: iOS 위치 서비스를 켜주세요")
    }
```


### 어플의 위치 권한 설정 확인

- CLAuthorizationStatus에 따라서 설정

```swift
func checkCurrentLocationAuthorization(authStatus: CLAuthorizationStatus) {
    switch authStatus {
    case .notDetermined:
        // locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // plist에서 wheninuse를 사용해서 이거로 요청하는거임
        // 앱을 사용하는 동안에 대한위치 권한 요청. notDetermined 때만 사용됨
        locationManager.requestWhenInUseAuthorization() 
        // 위치 접근 시작,didUpdateLocations 실행
        locationManager.startUpdatingLocation() 
    case .restricted, .denied:
        print("DENIED, 설정으로 유도")
    case .authorizedAlways:
        print("얘도 안씀")
    case .authorizedWhenInUse:
        // 위치 접근 시작,didUpdateLocations 실행
        locationManager.startUpdatingLocation() 
    //요즘은 안쓰는 부분
    //case .authorized:        
    @unknown default:
        print("DEFAULT")
    }
```

### 정확한 위치 사용 확인

- CLLocationManager 인스턴스의 accuracyAuthorization에서 확인
- iOS 14 이상에서 가능

```swift
if #available(iOS 14.0, *) {
    // 정확도 체크: 정확도 감소 되어 있는 경우, 제대로 동작하지 않는 앱이 있음. 배터리는오래쓰긴함.
    let accuracyState = locationManager.accuracyAuthorization
    
    switch accuracyState {
    case .fullAccuracy:
        print("FULL")
    case .reducedAccuracy:
        print("REDUCE, 알림 등이 제대로 안갈수 있다고 alert 할 필요가있음")
    @unknown default:
        print("DEFAULT")
    }
}
```

### didUpdateLocations
- CLLocationManagerDelegate 메서드
- 위치가 업데이트 되면 실행된다.
- 계속된 업데이트를 막기 위해 stopUpdatingLocation() 해야한다.

```swift
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            // coordinate를 이용한 코드....

            // (중요) 계속 업데이트 안되게 중단요청
            locationManager.stopUpdatingLocation()
        }
        else {
            print("Location CanNot Find")
        }
    }
```

### locationManagerDidChangeAuthorization
- iOS 14 이상, 미만은 (...didChangeAuthrization: ...) 사용
- 여기에서 디바이스 위치 권한을 확인해야한다.

```swift
func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {    
    checkUserLocationServiceAuthorization()
}
```