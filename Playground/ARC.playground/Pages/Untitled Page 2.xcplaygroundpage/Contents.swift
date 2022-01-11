import Foundation

protocol MyDelegate: AnyObject {
    func sendData(_ data: String)
}

class Main: MyDelegate {
    lazy var detail: Detail = {
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    func sendData(_ data: String) {
        print(data)
    }
    
    deinit {
        print("Main Deinit")
    }
}

class Detail {
    
    // 순환참조를 막기 위해서 weak 사용
    weak var delegate: MyDelegate?
    
    func dismiss() {
        delegate?.sendData("ㅎㅇ")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main()
var detail: Detail? = Detail()

//// detail이 lazy라서 detail을 사용하지 않고 바로 main에 nil을 넣으면 Deinit 실행은 됨
//main = nil

main?.detail.dismiss()
main = nil
