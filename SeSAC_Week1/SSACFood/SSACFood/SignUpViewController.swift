//
//  SignUpViewController.swift
//  SSACFood
//
//  Created by JD_MacMini on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
    }
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
}
