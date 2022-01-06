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

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    func transform(input: Input) -> Output
}


class ValidationViewModel: CommonViewModel {
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요합니다")
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let resultText = input.text
            .orEmpty
            .map { $0.count >= 8 }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: resultText,
                      validText: validText,
                      sceneTransition: input.tap)
    }
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
        bind()
    }
    
    func bind() {
        let input = ValidationViewModel.Input(text: nameTextField.rx.text,
                                              tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: button.rx.isEnabled, nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validText
            .bind(to: nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .bind {
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    func before() {
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
