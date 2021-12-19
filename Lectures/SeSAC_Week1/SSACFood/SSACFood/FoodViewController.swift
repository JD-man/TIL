//
//  FoodViewController.swift
//  SSACFood
//
//  Created by JD_MacMini on 2021/10/01.
//

import UIKit

class FoodViewController: UIViewController {
    
    @IBOutlet var tagButton1: UIButton!
    
    @IBOutlet var tagButton2: UIButton!
    
    @IBOutlet var tagButton3: UIButton!
    
    @IBOutlet var userSearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 매개변수 기본값 사용
        buttonUISetting(tagButton1)
        
        // button: 매개변수(parameter), tagbutton1: 전달인자(argument)
        //buttonUISetting(tagButton1, title: "사탕")
        buttonUISetting(tagButton2, title: "초콜릿")
        buttonUISetting(tagButton3, title: "츄러스")
    }
    
    // didEndOnExit
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        // 키보드 내리기
        view.endEditing(true)
    }
    
    // button: 외부매개변수, btn: 내부매개변수
    // 외부매개변수는 _을 사용해서 생략가능 -> 와일드카드 식별자
    // 오버로딩
    func buttonUISetting(_ btn: UIButton, title ttl: String = "사탕") {
        btn.setTitle(ttl, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        
    }
    
    @IBAction func foodTagButtonClicked(_ sender: UIButton) {
        userSearchTextField.text = sender.currentTitle
    }
}
