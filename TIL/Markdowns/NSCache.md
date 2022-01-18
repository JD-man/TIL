# 이미지 캐시를 위한 NSCache

## 목차
1. 사용이유
2. 예시
3. Dictionary와의 차이
4. 참고자료

---

## 1. 사용이유
- 이미지가 고화질, 고용량인 경우 매번 다운받으면 낭비되는 자원이 많으니 저장해놓고 사용하기 위해서 쓴다.
- 캐싱방법중 Memory Cache에 주로 사용된다. Disk Cache는 Filemanager를 사용한다.

---

## 2. 예시

- 캐싱을 도와줄 싱글턴
```swift
final class ImageCachingManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}
```

- NSCache에 저장된 이미지가 있다면 그걸 사용하고 아니면 이미지를 받아서 NSCache에 캐싱.
```swift
extension UIImageView {
    func setImage(url: String) {
        DispatchQueue.global().async {
            
            if let cached = ImageCachingManager.shared.object(forKey: NSString(string: url)) {
                print(cached)
                DispatchQueue.main.async {
                    self.image = cached
                    return
                }
            }
            
            URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.image = UIImage(systemName: "xmark")
                    }
                }
                else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCachingManager.shared.setObject(image, forKey: NSString(string: url))
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
```

---

## 3. Dictionary와의 차이??
- 이거하고나서 산책하러 나갔다가 Dictionary와 무슨 차이가 있는건가 생각나서 찾아봤다.
- 그랬더니 이런 질문을 다루는 블로그가 많았다!!

### 1) 메모리 해제
- 메모리에서 해제될 때 캐시된 내용이 제거된다.
- 메모리 자원이 부족하면 삭제 대상이 된다.
- 최근에 사용하지 않은거부터 쳐낸다.

### 2) Thread-Safe
- 주로 비동기로 이미지를 받으니 Thread-Safe한건 중요하다고 생각된다.

### 3) Key가 복사되어 들어가지 않는다.
- NSMutableDictionary와 다르게 키가 복사되어 들어가지 않는다.
- NSMutableDictionary는 키가 복사되는 이유?? retain이라면 그 key가 변경된 경우 value를 못찾기 때문.

### 4) NSCache는 키를 복사하지 않는 이유?? (내 생각. 찾아봐도 안나옴...)
- NSCache를 사용하는건 메모리 효율을 위해서인데 값을 복사해서 저장하는건 취지에 반한다.
- key 변경된 경우 value가 알아서 없어진다!!(참고자료 StackOverFlow 링크)
- 이런 행동들을 봤을때 메모리를 효율적으로 쓰고 해제를 용이하게 하기 위해서 retain 하는거로 보인다.

---

## 4. NSPurgeableData
- 위의 예제에서는 UIImage를 직접 넣었지만 NSData로 저장하기도 한다.
- NSCache가 오브젝트를 삭제할때에 대해서는 컨트롤하기가 힘들다.
- 이 때 NSPurgeableData를 사용한다.
- beginContentAccess를 이용해 NSCache에게 이 오브젝트를 지금 삭제하지 말라고 할 수 있다.
- endContentAccess를 이용해 끝난 작업을 NSCache에 업데이트할 수 있다.

---
# 참고자료
- [블로그](https://medium.com/@prasanna.aithal/dictionary-v-s-nscache-in-ios-a94f0e22602e)
- [NSCache](https://developer.apple.com/documentation/foundation/nscache)
- [StackOverFlow](https://stackoverflow.com/questions/69377994/does-the-different-way-of-handling-key-between-nsmutabledictionary-and-nscache/69378461#69378461%20%EC%B6%9C%EC%B2%98:%20https://beenii.tistory.com/187%20[%EB%81%84%EC%A0%81%EC%9D%B4%EB%8A%94%20%EA%B0%9C%EB%B0%9C%EB%85%B8%ED%8A%B8])