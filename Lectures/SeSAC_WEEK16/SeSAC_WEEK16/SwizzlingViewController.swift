//
//  SwizzlingViewController.swift
//  SeSAC_WEEK16
//
//  Created by JD_MacMini on 2022/01/10.
//

import UIKit

class SwizzlingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillAppear")
    }
}

extension UIViewController {
    // 메서드 -> 런타임 실행 메서드
    // #selector: 런타임에서 어떤 함수가 실행되는지 찾음
    class func swizzleMethod() {
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillApeear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin),
              let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
                  print("함수가 업ㅂ음")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
            
    @objc func changeViewWillApeear() {
        print("change View Will Appear")
    }
}
