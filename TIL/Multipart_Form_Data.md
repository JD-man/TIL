# Multipart Form Data

## Content-Type
- HTTP Header에서 MIME 타입을 표현한다
- 하나의 파일만을 서버에 업로드 한다면 명확한 타입으로 설정한다  
ex) png를 업로드한다면 Content-Type: image/png로 HTTP Header에 명시

## MIME 타입
- Multipurpose Internet Mail Extensions
- HTTP에서 전송되는 모든 파일들에 대한 데이터 포맷 라벨

## Multipart Form Data?
- 여러 파일을 서버에 업로드를 해야하는 경우라면 단일한 타입으로 표현하기 어렵다.
- 따라서 Content-Type을 multipart/form-data로 설정한다.
