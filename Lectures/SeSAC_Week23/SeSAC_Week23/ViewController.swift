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
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //firstTextField.accessibilityIdentifier = "firstTextField"
    }
    
    func calculateTextFieldTextCount() -> Int {
        return firstTextField.text?.count ?? 0
    }
    
    @IBAction func firstButtonClicked(_ sender: UIButton) {
        resultLabel.text = firstTextField.text
    }
}
