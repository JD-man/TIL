# Pagenation

## 정의
- 대량의 데이터와 리소스를 분할해서 가져오는 방법
- 사용자의 스크롤에 맞춰 데이터를 가져온다

## 종류

- OffsetPagenation
- CursorPagenation

## OffsetPagenation
- 페이지와 데이터개수를 쿼리스트링으로 전달
- 단점 : 정보를 요청하는 사이 서버에 새로운 데이터가 많이 올라오면 중복데이터가 표시될 가능성이 있음
- 서버의 데이터 변화가 적은 구조에서 사용하는 것이 안전
- PageNumberPagenation, LimitOffsetPagenation이 있다.

## CursorPagination
- 클라이언트가 가지고 있는 마지막 데이터를 기준으로 다음 데이터를 조회
- 단점 : 최신 데이터를 가져오기 힘들고, 중간 데이터를 건너뛰기 힘들다.

---

# iOS에서의 PageNation

## TableView willDisplayCell
- 화면에 보이지 않는 셀에서도 호출될 수 있는 가능성이 있어 권장되는 방식은 아니다.

## scrollViewDidScroll
- 보편적으로 많이 사용
- TableView, CollectionView는 ScrollView를 상속받는 것을 이용
- ScrollViewDelegate, scrollViewDidScroll 이용

## UITableViewDataSourcePrefetching Protocol
- iOS 10.0 이상 지원
- 서버 통신같은 비동기 상황에서 쉽게 구현 가능
- 용량이 큰 이미지를 표시하는데 유리
- 스크롤 성능 향상
### 과정
1. TableView 생성 및 prefetchDatasource 할당
2. UITableViewDataSourcePrefetching 프로토콜 채택
3. prefetchRowAt 메서드 사용, 비동기 처리 필요
4. 빠른 스크롤을 처리하기 위해 cancelPrefetchingForRowsAt 메서드 사용

- cellForRowAt이 호출되기 전 prefetchRowAt로 데이터를 받는다.

### 예시

```swift
extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if trendingMovie.count - 1 == indexPath.row, page < maxPage {
                page = min(page + 1, maxPage)
                fetchData(page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //print("Prefetching cancel")
    }
}
```