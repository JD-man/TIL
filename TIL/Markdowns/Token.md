# Token

## 목차
1. 필요성 - HTTP 특징
2. Authentication vs Authorization
3. Token vs Session
3. OAuth
4. JWT

---

## 1. 필요성 - HTTP 통신의 특징
### 1) Connectionless
- 클라이언트의 요청에 서버가 응답하면 연결을 끊어버리는 성질

### 2) Stateless
- 서버가 클라이언트의 이전 상태를 보존하지 않는다는 의미

### 3) 공통점
- 유저가 로그인 요청에 응답하면 서버는 연결을 끊고 유저의 로그인 상태를 모르기 때문에 페이지를 넘길 때마다 로그인이 필요
- 따라서 유저가 누구인지, 유저가 어떤상태인지 알아야할 필요가 있어 Token 또는 Session이 필요하다.

---

## 2. Authentication vs Authorization
### 1) Authentication
- 인증
- 로그인과 같이 유저가 누구인지 확인하는 과정
- 인증에 성공하면 세션 또는 토큰을 발급한다.

### 2) Authorization
- 인가
- 어떤 작업을 할 수 있는지 확인하는 과정
- 장바구니같이 인증된 유저만 요청할 수 있는 작업들을 위해 필요하다.

### 3) 방식
- 여러방식이 있지만 Session, Token 방식이 있다.

---

## 3. Token vs Session
### 1) Session
- 클라이언트의 정보를 서버에서 기억하는 방식이다.
- 유저가 로그인하면 세션을 만들거나 세션에 저장되어 있는 정보를 사용한다.
- 서버의 메모리 부담이 크고 서버 확장이 어렵다는 단점이 있다.
- 쿠키의 사용으로 멀티 디바이스 환경에서 로그인 관리를 해줘야 한다.

### 2) Token
- 인증받은 클라이언트에게 토큰을 주고 서버에 요청할 때 토큰을 같이 보내게하는 방식이다.
- Session의 단점인 서버의 확장성, 멀티디바이스 등을 대처할 수 있다.
- OAuth, JWT 방식을 주로 사용한다.

---

## 4. OAuth
### 1) 정의
- 유저가 비밀번호를 제공하지 않고 다른 웹사이트 상에 자신의 정보에 대한 접근권한을 부여할 수 있는 수단.
- 구글, 페이스북, 트위터  같은 서비스의 기능을 다른 애플리케이션에서도 사용할 수 있게 한것.

### 2) 인증방식 및 과정
- 서비스제공자(Service Provider) : OAuth를 사용하는 서비스 (구글 등)
- 소비자(Consumer) : 서비스제공자의 OAuth 기능을 사용하려는 서비스 (내가 만든 앱)
- 사용자(User) : 서비스제공자에 계정을 가지고 있는 소비자를 사용하려는 유저
- Request Token : 소비자가 서비스제공자에게 인증받기 위해 사용.
- Access Token : 소비자가 인증 받은 후에 사용하는 토큰

1. 소비자가 서비스제공자에게 Request Token 요청 및 발급. **(앱 <-> 구글)**
2. 소비자가 사용자를 서비스제공자로 이동시키고 사용자 인증 진행. **(앱 <-> 유저)**
3. 서비스제공자가 유저를 소비자로 이동시킴. **(유저 <-> 구글)**
4. 소비자가 Access Token 요청 및 발급. **(앱 <-> 구글)**
5. 발급된 Access Token을 이용해 소비자가 사용자 정보에 접근. **(앱 <-> 유저)**


---

## 5. JWT(Json Web Token)
### 1) 정의
- JSON을 기반으로하고 사용자 정보나 데이터 속성을 하는 클레임 기반 토큰.
- Header, Payload, Signature 세가지 구조로 만들어져있다.
- Header.Payload.Signature

### 2) Header
- typ와 alg 정보로 구성된다
- typ : 토큰의 타입
- alg : Signature 알고리즘

### 3) Payload
- 토큰에서 사용할 정보인 클레임이 들어있다.
- 등록된 클레임, 공개 클레임, 비공개 클레임이 있다.

### 4) Signature
- 토큰을 인코딩하거나 유효성 검증할 때 사용한다.