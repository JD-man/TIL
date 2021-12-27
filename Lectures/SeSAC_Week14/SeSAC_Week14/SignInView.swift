//
//  SignInView.swift
//  SeSAC_Week14
//
//  Created by JD_MacMini on 2021/12/27.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}

class SignInView: UIView, ViewRepresentable {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        addSubview(signInButton)
        signInButton.backgroundColor = .orange
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalTo(usernameTextField.snp.centerX)
            make.width.equalTo(usernameTextField)
            make.height.equalTo(usernameTextField)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(usernameTextField.snp.centerX)
            make.width.equalTo(usernameTextField)
            make.height.equalTo(usernameTextField)
        }
    }
}
