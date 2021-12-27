//
//  ViewController.swift
//  SeSAC_Week14
//
//  Created by JD_MacMini on 2021/12/27.
//


/* MVC - Model View Controller
 3개의 캠프
 Model: 데이터
 View: 그냥 뷰
 둘은 Controller 기반으로 소통을한다.
 Model, View는 직접 소통이 불가능.
 
 Controller는 모든걸 통제하고있음
 C-V 소통 : 1. V의 action, C의 target. addTarget/@IBAction 형식.
           2. C가 V의 delegate, datasource가 된다.
 
 Model의 변경 : Notification & KVO을 통해 C가 알게됨
 */

/*
 화면 하나당 MVC패턴으로 이루어져있음
 */


/*
 MVVM - Model View ViewModel
 Model: 모델과 UI는 독립적임. Data + Logic. The Truth.
 View: Stateless. 모델의 데이터를 보여주기만 하는 역할.
 ViewModel: Binds View To Model. Interpreter의 역할만함. 모델의 데이터를 가져와서 뷰에 알맞게 줌
 
 Model과 View는 여기서도 서로 모름.
 */

import UIKit

class SignInViewController: UIViewController {
    deinit {
        print("SignInVC deinit")
    }
    
    let signInView = SignInView()
    var viewModel = SignInViewModel()
    
    override func loadView() {
        super.loadView()
        view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        viewModel.username.bind { text in
            self.signInView.usernameTextField.text = text
        }
        viewModel.password.bind { text in
            self.signInView.passwordTextField.text = text
        }
        
        signInView.usernameTextField.addTarget(self, action: #selector(usernameTextFiledDidChange(_:)), for: .editingChanged)
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFiledDidChange(_:)), for: .editingChanged)
        signInView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func usernameTextFiledDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFiledDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        viewModel.postUserForSignIn {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
}

