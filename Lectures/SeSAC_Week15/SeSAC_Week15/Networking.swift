//
//  Networking.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/04.
//

import UIKit
import RxSwift
import SnapKit
import RxAlamofire

class Networking: UIViewController {

    let urlString = "https://aztro.sameerkumar.website/?sign=sagittarius&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    var disposeBag = DisposeBag()
    
    let label = UILabel()
    let number = BehaviorSubject<String>(value: "오늘의 숫자")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.frame = view.bounds
        label.backgroundColor = .systemBackground
        
        number
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
        json(.post, urlString)
            .subscribe { value in
                guard let data = value as? [String : Any] else { return }
                guard let result = data["lucky_number"] as? String else { return }
                print("==\(result)")
                self.number.onNext("\(result)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }.disposed(by: disposeBag)
        
    }
    
    func useURLSession(url: String) -> Observable<String> {
        return Observable.create { value in
            let url = URL(string: self.lottoURL)
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                if let data = data, let json = String(data: data, encoding: .utf8) {
                    value.onNext("\(json)")
                }
                value.onCompleted()
            }
            task.resume()
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
