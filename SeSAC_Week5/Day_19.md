# Week 5 - 19회차 2021.10.25
---

## 1. HTTP
- Hyper Text Transfer Protocol
- 인터넷에서 데이터를 주고받을 수 있는 프로토콜


### 특징
1. Request - Response
- 클라이언트의 요청이 있을 때 서버가 응답하는 방식
- Connectionless : 비연결성. 항상 새롭게 연결하고 해제해야한다.
- Stateless : 무상태. 서버는 클리언트를 식별할 수 없다. 쿠키, 세션, 토큰을 통해 클라이언트 식별

2. HTTP Method
- 클라이언트가 서버에 요청할 때, 요청하는 목적을 알리는 수단
- GET, POST, PUT, DELETE


### 상태코드
- 클라이언트와 서버 간 통신의 성공/실패 여부 및 오류 원인을 알려주는 코드

- 1XX(정보): 요청을 받앗으며 프로세스를 계속한다
- 2XX(성공): 요청을 성공적으로 받았으며 인식했고 수용했다
- 3XX(리다이렉션): 추가 작업 조치가 필요하다
- 4XX(클라이언트 오류): 요청이 잘못됐거나 처리할 수 없다
- 5XX(서버 오류) : 서버 오류로 요청에 대해 실패

### HTTP 메세지
- 라인 - 헤더 - 바디 구조로 이루어져 있음
- 라인 : Method, Path, Version of Protocol로 구성
- HTTP Header : 메타정보. ex) Content-Type
- HTTP Body : 보내고자 하는 메세지 본문. POST 등 에서 사용

## 2. JSON, XML
### XML
- eXtensive Markup Language
- <>를 사용하는 구조
- iOS는 XMLParser로 데이터 분석 가능

### JSON 방식
- Javascript Object Notation
- {키:데이터} 형태