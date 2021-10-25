//
//  ViewController.swift
//  FutherAutoLayout
//
//  Created by JD_MacMini on 2021/10/22.
//

import UIKit

/*
 Button : Device 수평 수직 중앙
 
 Button, Label 등은 컨텐츠 크기에 영향을 받음
 */

class ViewController: UIViewController {

    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var isHeightUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func changeHeightButtonClicked(_ sender: UIButton) {
        containerViewHeightConstraint.constant = isHeightUp ? 50 : 150
        isHeightUp = !isHeightUp
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

