//
//  FrameworkTestViewController.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/23.
//

import UIKit
import SeSACFramework

class FrameworkTestViewController: OpenSeSAC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        presentWebViewController(url: "http://www.naver.com",
                                 transitionStyle: .push,
                                 vc: self)
    }
}
