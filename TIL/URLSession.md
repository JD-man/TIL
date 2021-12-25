# URLSession

## 목차
1. URLSession
2. URLSessionConfiguration
3. URLSessionTask
4. URLRequest
5. URLResponse
6. 주의점

---

## 1. URLSession
- 데이터를 다운로드/업로드 하는 등의 API를 제공하는 클래스.
- 타임아웃, 캐시 정책, 백그라운드 사용 등 설정 가능.
- shared Session을 이용해 기본적인 사용 가능.

---

## 2. URLSessionConfiguation
### 1) 의의
- URLSession의 세부적인 동작과 정책 설정
- 일반적인 프로퍼티 설정 : 셀룰러 사용, 타임 아웃, 리소스 요청 최대 시간 등 
- 이외에도 캐시, 쿠키, 보안, 백그라운드 전송 등 설정

### 2) Shared Session
- 싱글턴 패턴의 기본 설정
- 커스터마이징 불가
- 응답에 대해서는 Completion Handler 사용
- 백그라운드 전송 지원 안함

### **이 밑으로 URLSessionConfiguration을 통해 직접 생성함**
### 3) Default Session
- 기본설정은 Shared 설정과 유사하지만 커스터마이징 가능.
- 응답에 대해서는 Delegate를 통해 세부적인 제어 가능.

### 4) Ephemeral Session
- 쿠키, 캐시, 인증 정보 등을 디스크에 기록하지 않음
- 시크릿모드 같이 private한 기능 구현에 사용

### 5) Background Session
- 앱이 실행중이지 않을때나 백그라운드 상태에서도 데이터 다운로드/업로드 가능.

---

## 3.URLSessionTask
- URLSession이 만들어진 후 생성하는 개별요청
- 데이터 전달 방식 및 구현목적에 따라 DataTask, UploadTask, DownloadTask, StreamTask로 나누어진다.
- Task는 생성시 suspended 상태이므로 resume()을 사용해 통신을 시작시켜야한다.

---

## 4. URLRequest
- 요청에 대한 정보를 가지는 객체
- URL, Method, Header 등을 설정할 수 있다.

---

## 5. URLResponse
- 요청에 대한 응답의 메타데이터
- HTTPURLResponse의 인스턴스
- Completion Handler 또는 Session Delegate를 통해 데이터를 처리한다.
- 전자의 경우 Task가 종료되고 난 시점에 한번만 받으며 response 또는 error를 전달받는다.
- 후자의 경우 Task가 실행되는 동안의 상황에 대해서 다양하게 처리가 가능하다.  
  (최초로 응답을 받을 때, 데이터를 받을 때마다, 데이터를 모두 받았을때 등 세부적으로 처리 가능)

---

## 6. 주의점
- UI 업데이트는 메인스레드에서 해야하므로 뷰컨트롤러의 UI를 업데이트할땐  
  DispatchQueue.main.async { UI Update code }