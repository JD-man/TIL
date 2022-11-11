import Foundation

protocol ChapterOneProtocol {
  static var typeProperty: String { get }
  
  static func typeMethod() -> Void
  
  mutating func mutatingFunc() -> Void
  
}

struct ChapterOneStruct: ChapterOneProtocol {
  mutating func mutatingFunc() {
    print("mutating some property")
  }
  
  static func typeMethod() {
    print("Chapter 1 typeMethod")
  }
  
  static var typeProperty: String = "Chapter 1 typeProperty"
}

class ChapterOneClass: ChapterOneProtocol {
  static var typeProperty: String = "..."
  
  static func typeMethod() {
    print("...")
  }
  
  func mutatingFunc() {
    print("fix시 알아서 mutating 제거돼서 나옴")
  }
}

func returnProtocol() -> ChapterOneProtocol {
  print("Return protocol")
  return ChapterOneStruct()
}

returnProtocol()
