import UIKit

//struct Endpoint {
//    static let baseURL = "http://test.monocoding.com/"
//
//    static let singup = baseURL + "auth/local/register"
//    static let login = baseURL + "auth/local"
//    static let board = baseURL + "boards"
//}

enum Endpoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .login: return .makeEndpoint("auth/local")
        case .signup: return .makeEndpoint("auth/local/register")
        case .boards: return .makeEndpoint("boards")
        case .boardDetail(id: let id):
            return .makeEndpoint("boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    static func makeEndpoint(_ endpoint: String) -> URL {
        return URL(string: baseURL + endpoint)!
    }
    
    static var login: URL {
        return makeEndpoint("auth/local")
    }
    
    static var signup: URL {
        return makeEndpoint("auth/local/register")
    }
    
    static var boards: URL {
        return makeEndpoint("boards")
    }
    
    static func boardDetail(number: Int) -> URL {
        makeEndpoint("boards/\(number)")
    }
}

URLSession.shared.dataTask(with: Endpoint.signup.url)
print(Endpoint.signup.url)
print(Endpoint.boardDetail(id: 2599).url)
