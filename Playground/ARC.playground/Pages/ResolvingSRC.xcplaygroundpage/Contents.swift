import Foundation

//// weak
//
//
//class Person {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    var apartment: Apartment?
//
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//class Apartment {
//    let unit: String
//
//    init(unit: String) {
//        self.unit = unit
//    }
//
//    weak var tenant: Person?
//
//    deinit {
//        print("Apartment \(unit) is being deinitialized")
//    }
//}
//
//var jd: Person? = Person(name: "JD")
//var unit4A: Apartment? = Apartment(unit: "4A")
//
//jd!.apartment = unit4A
//unit4A!.tenant = jd
//
//jd = nil
//
//print(unit4A!.tenant)
//unit4A = nil


//// unowned
//
//class Customer {
//    let name: String
//    var card: CreditCard?
//    init(name: String) {
//        print("Customer \(name) is initialized")
//        self.name = name
//    }
//    deinit {
//        print("Customer \(name) is deinitialized")
//    }
//}
//
//class CreditCard {
//    let number: UInt64
//    unowned let customer: Customer
//    init(number: UInt64, customer: Customer) {
//        print("CreditCard \(number) of Customer \(customer.name) is initialized")
//        self.number = number
//        self.customer = customer
//    }
//    deinit {
//        print("CreditCard \(number) is deinitialized")
//    }
//}
//
//var jd: Customer? = Customer(name: "JD")
//jd!.card = CreditCard(number: 1234, customer: jd!)
//
//jd = nil

//// unowned optional
//
//class Department {
//    var name: String
//    var courses: [Course]
//    init(name: String) {
//        self.name = name
//        self.courses = []
//    }
//}
//
//class Course {
//    var name: String
//    unowned var department: Department
//    unowned var nextCourse: Course?
//    init(name: String, in department: Department) {
//        self.name = name
//        self.department = department
//        self.nextCourse = nil
//    }
//}
//
//let department = Department(name: "JD")
//
//let intro = Course(name: "Intro", in: department)
//let intermediate = Course(name: "Intermediate", in: department)
//let advanced = Course(name: "Advanced", in: department)
//
//intro.nextCourse = intermediate
//intermediate.nextCourse = advanced
//
//department.courses = [intro, intermediate, advanced]

// unowned unwrapped optional

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}


var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
