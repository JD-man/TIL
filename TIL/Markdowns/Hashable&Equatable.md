# Hashable & Equatable

## 목차
1. Equatable
2. Hashable

---

## 1. Equatable
### 1) 정의
- 값이 같은지 비교할 수 있게 만드는 프로토콜

### 2) 사용이유
- == 또는 !=로 같은값인지 아닌지 비교가 필요할때 사용한다.

### 3) Struct, Enum
- 구조체에 사용하기 위해서는 모든 저장프로퍼티가 Equatable이어야함
- 열거형에 사용하기 위해서는 모든 연관값이 Equatable이어야함

---

## 2. Hashable
### 1) 정의
- integer hash value를 만들기 위해 hash될 수 있는 타입으로 만드는 프로토콜

### 2) 사용이유
- set이나 dictionary의 key로 사용하기 위해서 필요하다.
- 값을 찾아내는 시간이 빠르기 때문에 hash value를 사용한다.
- hash table에서 hash value를 index로 사용하기 때문이다.

### 3) Equatable 상속
- 각 hash value가 같은지 확인이 필요하기 때문에 Equatable 프로토콜을 상속하고 있다.

### 4) Struct, Enum
- 구조체에 사용하기 위해서는 모든 저장프로퍼티가 Hashable이어야함
- 열거형에 사용하기 위해서는 모든 연관값이 Hashable이어야함