//
//  Subject.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/04.
//

import UIKit
import SnapKit
import RxSwift

class Subject: UIViewController {
    
    let label = UILabel()
    
    //let nickname = Observable.just("JD")
    let nickname = PublishSubject<String>()
    
    
    let array1 = [1,1,1,1,1,1,1]
    let array2 = [2,2,2,2,2]
    let array3 = [3,3,3,3]
    
    // Subjects
    let publish = PublishSubject<[Int]>()
    let behavior = BehaviorSubject<[Int]>(value: [5,5,5,5,5])
    let replay = ReplaySubject<[Int]>.create(bufferSize: 3)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let random1 = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
                
        random1
            .subscribe { value in
                print("\(value)")
            }
            .disposed(by: disposeBag)
        
        random1
            .subscribe { value in
                print("\(value)")
            }
            .disposed(by: disposeBag)
        
        let randomSubject = BehaviorSubject(value: 0)
        
        randomSubject.onNext(Int.random(in: 1...100))
        
        randomSubject
            .subscribe { value in
                print("\(value)")
            }
            .disposed(by: disposeBag)
        
        randomSubject
            .subscribe { value in
                print("\(value)")
            }
            .disposed(by: disposeBag)
        
    }
    
    func aboutReplaySubject() {
        
        replay.onNext(array1)
        replay.onNext(array2)
        // 캐싱된건 주고감
        replay.onCompleted()
        replay.onNext(array3)
        replay.onNext(array3)
        
        replay
            .subscribe { value in
                print("\(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }.disposed(by: disposeBag)
        
        replay.onNext([8,8,8,8,8])
    }
    
    func aboutBehaviorSubject() {
        
        behavior.onNext(array1)
        behavior.onNext(array2)
        behavior.onNext(array3)
        
        behavior
            .subscribe { value in
                print("\(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }.disposed(by: disposeBag)
    }
    
    func aboutPublishSubject() {
        publish
            .subscribe { value in
                print("\(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }.disposed(by: disposeBag)

        publish.onNext(array1)
        publish.onNext(array2)
        publish.onCompleted()
        publish.onNext(array3)
    }
    
    func setup() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.backgroundColor = .white
        label.textAlignment = .center
    }
    
    func aboutSubject() {
        nickname
            .bind(to: label.rx.text) // subscribe vs bind vs drive
            .disposed(by: disposeBag)
        nickname.onNext("Hi JD")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nickname.onNext("Hi~")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.nickname.onNext("Hi~ Hi~")
        }
    }
}
