import UIKit

// map, filter, reduce

// 고차함수 : 1급 객체 / 매개변수와 반환값에 함수 -> map, filter, reduce

// 학생 4.0 이상
let student = [2.2, 5.0, 4.3, 3.3, 2.8, 1.5]

//var resultStudent: [Double] = []
//
//for i in student {
//    if i >= 4.0 {
//        resultStudent.append(i)
//    }
//}
//print(resultStudent)

//let resultFilter = student.filter { value in
//    value >= 4.0
//}

let resultFilter = student.filter { $0 >= 4.0 }

print(resultFilter)

// 원하는 영화 가져오기

let movieList = [
    "박쥐" : "박찬욱",
    "기생충" : "봉준호",
    "인터스텔라" : "크리스토퍼 놀란",
    "인셉션" : "크리스토퍼 놀란",
    "옥자" : "봉준호"
]




//for (movieName, director) in movieList {
//    if director == "봉준호" {
//      //.....
//    }


let movieResult = movieList.filter { $0.value == "봉준호" }
print(movieResult)

//map
let number = [1,2,3,4,5,6,7,8,9]

//var resultNumber: [Int] = []
//for n in number {
//    let value = n * 2
//    resultNumber.append(value)
//}
//print(resultNumber)

let resultNumber = number.map { $0 * 2 }
print(resultNumber)

let mappedMovieResult = movieResult.map { $0.key }
print(mappedMovieResult)

// reduce
let exam = [ 20, 40, 100, 90, 10, 70]

//var totalCount = 0
//for i in exam {
//    totalCount += i
//}
//print(totalCount)

let totalCount = exam.reduce(0) { $0 + $1 }
print(totalCount)

// sorted

let sortedMovieList = movieList.sorted { $0.key < $1.key }
print(sortedMovieList)
print(sortedMovieList.map {$0.key})
