import UIKit

// Array Capacity

var sample = Array(repeating: "가", count: 100)

sample.count
sample.capacity

sample.append(contentsOf: Array(repeating: "나", count: 100))

// Array가 커질수록 capacity의 증가수치가 늘어나서 메모리 재할당에 의한 복사의 빈도가 줄어들어 평균치의 성능을 낸다.
sample.count
sample.capacity

var sample2: [Int] = []

for i in 1 ... 200 {
    sample2.append(i)
    sample2.count
    sample2.capacity
}

// replacingOccurence

var str = "Hello World - Hello"
var title = "Squid Game".lowercased().replacingOccurrences(of: " ", with: "_")


