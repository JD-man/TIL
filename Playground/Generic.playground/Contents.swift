import UIKit

var apple = 8
var banana = 3

//print(apple, banana)
//swap(&apple, &banana)
//print(apple, banana)

//func swapTwoInts(a: inout Int, b: inout Int) {
//    let tempA = a
//    a = b
//    b = tempA
//}
//
//print(apple, banana)
//swapTwoInts(a: &apple, b: &banana)
//print(apple, banana)
//
//func swapTwoDoubles(a: inout Double, b: inout Double) {
//    let tempA = a
//    a = b
//    b = tempA
//}
//
//func swapTwoString(a: inout String, b: inout String) {
//    let tempA = a
//    a = b
//    b = tempA
//}
//
var fruit1 = "사과"
var fruit2 = "바나나"
//
//print(fruit1, fruit2)
//swapTwoString(a: &fruit1, b: &fruit2)
//print(fruit1, fruit2)


// T : 타입 파라미터 - 함수 정의 시 타입 X, 함수 호출 시 매개변수 타입으로 대체되는 Placeholder
func swapTwoValues<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

print(fruit1, fruit2)
swapTwoValues(a: &fruit1, b: &fruit2)
print(fruit1, fruit2)

//func total(a: [Int]) -> Int {
//    return a.reduce(0, +)
//}
//
//func total(a: [Double]) -> Double {
//    return a.reduce(0, +)
//}

// Generic

func total<T: AdditiveArithmetic>(a: [T]) -> T {
    return a.reduce(.zero, +)
}
total(a: [1,2,3])

//let strArr: [String] = ["1", "2", "3"]
//total(a: strArr)

// navigation
struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
}

extension Stack {
    var topElement: T? {
        return self.items.last
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("우왕")
stackOfStrings.push("굳")
stackOfStrings.pop()

func equal<T: Animal>(a: T, b: T) -> Bool {
    return a == b
}

class Animal: Equatable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let cat = Animal(name: "고양이")
let horse = Animal(name: "말")

print(equal(a: cat, b: horse))
print(cat == horse)


class Dog: Animal {
    
}

class Cat {
    
}


// 화면전환
import UIKit



class ViewController: UIViewController {
    
    func transitionViewController<T: UIViewController>(sb: String, vc: String) -> T {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! T
        self.present(vc, animated: true, completion: nil)
        return vc
    }
    
}
