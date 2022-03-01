//
//  ViewController.swift
//  SeSAC_Week23
//
//  Created by JD_MacMini on 2022/02/28.
//

import UIKit

protocol TextFieldTextCountDelegate {
    func calculateTextFieldTextCount(_ text: String) -> Int
}

class ViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calculateTextFieldTextCount() -> Int {
        return firstTextField.text?.count ?? 0
    }
}
