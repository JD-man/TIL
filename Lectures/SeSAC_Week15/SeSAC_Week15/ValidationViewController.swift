//
//  ValidationViewController.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/05.
//

import UIKit
import SnapKit
import RxRelay
import RxSwift
import RxCocoa

class ValidationViewModel {
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요합니다")
    
}

class ValidationViewController: UIViewController {
    
    let nameValidationLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    var viewModel = ValidationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.validText
            .asDriver()
            .drive(nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = nameTextField.rx.text
            .orEmpty
            .map { $0.count >= 8 }
            .share(replay: 1, scope: .whileConnected)
        
        validation
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .bind(to: nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
                
            }.disposed(by: disposeBag)
        
    }
    
    func setup() {
        [nameValidationLabel, nameTextField, button]
            .forEach {
                $0.backgroundColor = .lightGray
                view.addSubview($0)
            }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        nameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
