//
//  ViewController.swift
//  SeSAC_Week7
//
//  Created by JD_MacMini on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, PassDataDelegate {
    
    func sendTextData(text: String) {
        textView.text = text
    }

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(noti:)), name: .firstNotification, object: nil)
    }
    
    @objc func firstNotification(noti: Notification) {
        print("notification")
        guard let userInfo = noti.userInfo else {
            return
        }
        print(userInfo)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else {
            return
        }
        vc.buttonActionHandler = { [weak self, weak vc] in
            print("handler")
            self?.textView.text = vc?.textView.text
        }
        vc.textSpace = textView.text
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
}

