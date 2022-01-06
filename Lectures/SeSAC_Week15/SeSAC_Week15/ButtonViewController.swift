//
//  ButtonViewController.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ButtonViewModel {
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: result)
    }
}

class ButtonViewController: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    
    var disposeBag = DisposeBag()
    let viewModel = ButtonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        // 버튼 탭 -> 안녕 반가워! -> 레이블
        
//        button.rx.tap
//            .asDriver()
//            .drive { _ in
//                self.label.text = "안녕 반가워!"
//            }.disposed(by: disposeBag)
//
//        button.rx.tap
//            .asDriver()
//            .map { "안녕 반가워!" }
    }
    
    func bind() {
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(button)
        view.addSubview(label)
        button.backgroundColor = .white
        label.backgroundColor = .lightGray
        
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(20)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
