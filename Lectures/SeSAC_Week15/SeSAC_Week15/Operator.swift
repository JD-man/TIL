//
//  Operator.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/03.
//
import UIKit
import RxSwift

enum ExampleError: Error {
    case fail
}

class Operator: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let items2 = [1.3, 2.0, 3.0, 4.0, 5.6, 6.8]
        
//        Observable<Double>.create { observer -> Disposable in
//            for i in items {
//                if i < 3.0 {
//                    observer.onError(ExampleError.fail)
//                    break
//                }
//                observer.onNext(i)
//            }
//            observer.onCompleted()
//            return Disposables.create()
//        }.subscribe { item in
//            print(item)
//        } onError: { error in
//            print(error)
//        } onCompleted: {
//            print("completed")
//        } onDisposed: {
//            print("disposed")
//        }.disposed(by: disposeBag)
        
        
        Observable.just(items)
            .subscribe { item in
                print(item)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }.disposed(by: disposeBag)
        
        
        Observable.of(items, items2)
            .subscribe { item in
                print(item)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }.disposed(by: disposeBag)
        
        Observable.from(items)
            .subscribe { item in
                print(item)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }.disposed(by: disposeBag)
        
    }
}
