import Foundation

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    
    init(unit: String) {
        self.unit = unit
    }
    
    var tenant: Person?
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var jd: Person?
var unit4A: Apartment?

jd = Person(name: "JD")
unit4A = Apartment(unit: "4A")

jd!.apartment = unit4A
unit4A!.tenant = jd

jd = nil
unit4A = nil
