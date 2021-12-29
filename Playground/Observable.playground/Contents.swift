import UIKit

class Observable<T> {
    private var listner: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listner = closure
    }
}

class User<T> {
    
    var listner: ((T) -> Void)?
    
    var name: T {
        didSet {
            listner?(name)
            //changedName()
        }
    }
    
    
    init(_ name: T) {
        self.name = name
    }
    
    func changedName(_ completion: @escaping (T) -> Void) {
        completion(name)
        listner = completion
    }
}

let user = User("우왕굳")
user.name = "왕굳우"


//

func hello(name: String, age: Int) -> String {
    return "\(name): \(age)살"
}

let a = hello(name: "우왕", age: 19)

let b = hello
b("왕굳", 20)
