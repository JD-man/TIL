//: [Previous](@previous)

import Foundation

struct User: Encodable {
    var name: String
    var signUpdate: Date
    var age: Int
}


let users: [User] = [
    User(name: "user1", signUpdate: Date(), age: 33),
    User(name: "user2", signUpdate: Date(timeInterval: -86400, since: Date()), age: 18),
    User(name: "user3", signUpdate: Date(timeIntervalSinceNow: 86400 * 2), age: 11)
]

dump(users)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
encoder.dateEncodingStrategy = .iso8601

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "yyyy년 MM월 dd일 EEEE"
encoder.dateEncodingStrategy = .formatted(format)

do {
    let jsonData = try encoder.encode(users)
    guard let jsonStr = String(data: jsonData, encoding: .utf8) else { fatalError("error") }
    print(jsonStr)
}
catch {
    print(error)
}
