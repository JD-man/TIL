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

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

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
        
        
        useURLSession()
            .decode(type: Lotto.self, decoder: JSONDecoder())
            .bind {
                print($0)
            }.disposed(by: disposeBag)
//            .share()
//
//        request
//            .subscribe { _ in
//                print("value1")
//            }.disposed(by: disposeBag)
//
//        request
//            .subscribe { _ in
//                print("value2")
//            }.disposed(by: disposeBag)
        
    }
    
    func rxAF() {
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
    
    
    
    func useURLSession() -> Observable<Data> {
        return Observable.create { value in
            let url = URL(string: self.lottoURL)
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                if let data = data {
                    print("datatask resume")
                    value.onNext(data)
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
