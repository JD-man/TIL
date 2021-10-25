//
//  SignUpViewController.swift
//  SSACMOVIE
//
//  Created by JD_MacMini on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var additionalInfoSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        print("회원가입 정보 확인")
        print("ID: \(emailTextField.text!)")
        print("PW: \(passwordTextField.text!)")
        if additionalInfoSwitch.isOn {
            print("NICK: \(nicknameTextField.text!)")
            print("LOCATION: \(locationTextField.text!)")
            print("CODE: \(codeTextField.text!)")
        }
    }
    @IBAction func additionalInfoSwitchClicked(_ sender: UISwitch) {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
            self?.nicknameTextField.isHidden.toggle()
            self?.locationTextField.isHidden.toggle()
            self?.codeTextField.isHidden.toggle()
        }
        
        animator.startAnimation()
    }
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
