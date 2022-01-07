//
//  GradeCalculator.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/03.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class GradeCalulator: UIViewController {
    let mySwitch = UISwitch()
    let first = UITextField()
    let second = UITextField()
    let resultLabel = UILabel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        Observable.of(true)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        //        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty) { textValue1, textValue2 -> String in
        //            print("Input: (\(textValue1) + \(textValue2)) / 2")
        //            return String(((Double(textValue1) ?? 0.0) + (Double(textValue2) ?? 0.0)) / 2)
        //        }
        //        .bind {
        //            print("Output: \($0)")
        //        }
        //        .disposed(by: disposeBag)
        
        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty)
            .map {
                String(((Double($0) ?? 0.0) + (Double($1) ?? 0.0)) / 2)
            }
            .bind {
                print("Output: \($0)")
            }
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(mySwitch)
        view.addSubview(first)
        view.addSubview(second)
        view.addSubview(resultLabel)
        
        first.backgroundColor = .lightGray
        second.backgroundColor = .lightGray
        resultLabel.backgroundColor = .lightGray
        
        
        mySwitch.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        first.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        second.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(200)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(300)
        }
    }
}
