import Foundation

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialzed")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "JD")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil
