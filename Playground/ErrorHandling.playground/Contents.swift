import UIKit

func checkDateFormat(text: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    return formatter.date(from: text) == nil ? false : true
}

//func validateUserInput(text: String) -> Bool {
//    // 사용자가 입력한 값이 빈 값일 경우
//    guard !(text.isEmpty) else {
//        print("빈값임")
//        return false
//    }
//
//    // 사용자가 입력한 값이 숫자인지 아닌지
//    guard Int(text) != nil else {
//        print("숫자가 아님")
//        return false
//    }
//
//    // 사용자가 입력한 값이 날짜 형태로 변환이 되는 숫자인지 확인
//    guard checkDateFormat(text: text) else {
//        print("날짜 형태가 아닙니다")
//        return false
//    }
//
//    return true
//}
//
//if validateUserInput(text: "20220000") {
//    print("검색 가능")
//}
//else {
//    print("검색 불가")
//}

// -----------------------------------------------------------------

// 오류 처리 패턴: do try catch / Error Protocol
// 컴파일러가 오류 타입을 인정

enum ValidationError: Error {
    case emptyString
    case invalidInt
    case invalidDate
    
    var description: String {
        switch self {
        case .emptyString:
            return "값이 비어 있습니다"
        case .invalidInt:
            return "숫자가 아닙니다"
        case .invalidDate:
            return "날짜 형태가 아닙니다"
        }
    }
}

func validateUserInputError(text: String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.invalidInt
    }
    
    guard checkDateFormat(text: text) else {
        throw ValidationError.invalidDate
    }
    
    return true
}

//do {
//    let result = try validateUserInputError(text: "22003320")
//    print(result, "성공")
//}
//catch ValidationError.emptyString {
//    print("값이 비어 있습니다.")
//}
//catch ValidationError.invalidInt {
//    print("숫자 값이 아닙니다.")
//}
//catch ValidationError.invalidDate {
//    print("날짜 값이 아닙니다.")
//}

do {
    let result = try validateUserInputError(text: "22003320")
    print(result, "성공")
}
catch {
    switch error {
    case ValidationError.emptyString:
        print(ValidationError.emptyString.description)
    case ValidationError.invalidInt:
        print(ValidationError.invalidInt.description)
    case ValidationError.invalidDate:
        print(ValidationError.invalidDate.description)
    default:
        print("default")
    }
}


do {
    let result = try validateUserInputError(text: "22003320")
    print(result, "성공")
}
catch {
    let err = error as! ValidationError
    switch err {
    case .emptyString:
        print(err.description)
    case .invalidInt:
        print(err.description)
    case .invalidDate:
        print(err.description)
    }
}



