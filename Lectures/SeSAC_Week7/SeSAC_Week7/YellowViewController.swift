//
//  YellowViewController.swift
//  SeSAC_Week7
//
//  Created by JD_MacMini on 2021/11/10.
//

import UIKit

protocol PassDataDelegate: AnyObject {
    func sendTextData(text: String)
}

class YellowViewController: UIViewController {
    
    deinit {
        print("deinit yellow")
    }
    
    var textSpace: String = ""
    @IBOutlet weak var textView: UITextView!
    
    var buttonActionHandler: (() -> ())!
    
    var delegate: PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = textSpace
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        buttonActionHandler()        
        
        dismiss(animated: true) { [weak self] in
            print(self?.presentingViewController)
            print(self?.storyboard)
            print(self)
        }
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .firstNotification,
                                        object: nil,
                                        userInfo: ["text" : textView.text!,
                                                   "value" : 123])
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension NSNotification.Name {
    static let firstNotification = NSNotification.Name("firstNotification")
}
