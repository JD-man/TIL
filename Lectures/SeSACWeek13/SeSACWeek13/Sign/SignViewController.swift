//
//  SignViewController.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/22.
//

import UIKit

class SignViewController: BaseViewController {
    
    var mainView = SignView()
    // viewModel이 커지면 여러개로 쪼개서 사용하기도 한다. 1대다 관계가 됨.
    var viewModel = SignViewModel()
        
    // 뷰컨트롤러의 루트뷰를 로드할때 호출되는 메서드
    // 새로운 뷰를 반환하려고 할 때 사용
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind { text, color in
            self.mainView.emailTextField.text = text
            self.mainView.emailTextField.textColor = color
        }
    }
    
    override func configure() {
        title = viewModel.navigationTitle
        view.backgroundColor = .systemIndigo
        mainView.emailTextField.placeholder = "Email..."
        mainView.emailTextField.text = viewModel.text
        mainView.passwordTextField.placeholder = "Password..."
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        mainView.signButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    override func setupConstraints() {
        
    }
    
    @objc func signButtonClicked() {
        print(#function)
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
    }
}
