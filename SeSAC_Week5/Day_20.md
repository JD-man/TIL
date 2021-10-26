# REST API

## REST API란
- Representational State Transfer
- 네트워크를 통해서 활용할 수 있도록 제공되는 인터페이스, 아키텍쳐 스타일
- 프로토콜이 아니다
- 자원을 중심으로 엔드포인트를 생성하고 HTTP method를 통해 동작

## REST 6원칙
- **Uniform Interface**  
  자원에 대한 식별이 가능해야한다, HTTP method를 통해 자원을 조작

- **Stateless**  
  HTTP로 구현되기 때문에 HTTP의 Stateless 성질을 가진다

- **Cacheable**  
  HTTP의 특징인 캐싱 기능을 활용해 서버의 부하를 감소시킬 수 있다.

- **Self-descriptiveness**  
  REST API 메세지(Response/요청 URL/Endpoint)만 보고도 어떤 의도로 만들었는지 알아야한다.
- **Client - Server 구조**
- **계층형 구조**

## 장점
- 기존 TCP/IP 연결을 통해 HTTP(S)에서 손쉽게 구현 가능
- 특정 언어나 기술에 종속되지 않는다.

## 단점
- **Overfetching**  
  필요한 정보값보다 더 많은 정보값이 로딩될 수 있다.  
  ex) 사용하려는 데이터 1개를 위해 모든 정보를 받아야한다.

- **Underfetching**  
  필요한 정보보다 부족한 정보 로딩으로 추가 API 요청이 필요할 수 있다.  
  ex) 정보들이 여러 API로 분산된 경우

---

# URL

## 구성
- scheme + host + path + querystring
- URL에서는 ASCII 코드값만 사용

## URL Encoding
- 한글, 특수문자 같은 경우 인코딩이 필요
- MIME type : application/x-www-form-urlencoded
```swift
let encoded = "한글".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
```

---

# Serialization, Deserialization

## Serialization - 직렬화
- 메모리에 있는 Reference Type을 외부에서도 사용할 수 있게 Value Type으로 변환하는 과정
- 시스템에서 사용하는 클래스의 인스턴스 등을 디스크에 저장하거나 네트워크로 전송할 수 있는 형식으로 변환하는 작업
- Encoding
- ex) 앱에서 사용한 Dictionary를 JSON 형태 문자열로 전송

## Deserialization - 역직렬화
- Serialization의 반대
- Decoding
- ex) 네트워크로 받은 JSON 문자열을 앱에서 사용하기 위해 struct, class, dictionary 등으로 변환
