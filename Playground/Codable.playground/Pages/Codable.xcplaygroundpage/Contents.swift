import UIKit

let json = """
{
  "quote_content": "Your body is made to move so move it.",
  "author_name": "Toni Sorenson"
}
"""

struct Quote: Codable {
    var quote: String
    var author: String
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote_content"
        case author = "author_name"
    }
}

// String -> Data
guard let jsonData = json.data(using: .utf8) else { fatalError("fatal error") }
print(jsonData)

// Data -> Quote

let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase

do {
    let decoded = try decoder.decode(Quote.self, from: jsonData)
    print(decoded.quote)
    print(decoded.author)
}
catch {
    print(error)
}



// Meta Type
// String의 타입은 String.type. 메타 타입은 클래스 구조체 열거형 등의 유형 자체를 가리킴
let author = "화자"
type(of: author) // String.Type

//let quote = Quote(quote: "명언", author: "화자")
//type(of: quote) // 인스턴스에 대한 타입. 구조체 자체의 타입은?? Quote.Type

struct User {
    var name = "고래밥"
    static let identifier = 1234567 // 타입 프로퍼티
}

let user = User()
user.name

// 인스턴스에서는 identifier에서 접근못함
User.identifier
User.self.identifier
type(of: user).identifier

// 이를 이용하면 컴파일때가 아니라 런타임때의 타입을 알 수 있다.
// age는 Any로 만들었지만 런타임땐 Int가 됨
let age: Any = 15
type(of: age)

