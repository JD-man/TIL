//
//  AccessClass.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/23.
//
import UIKit

class AccessClass {
    internal var internalNum: Int = 0
    fileprivate var fpNum: Int = 1
    private var pNum: Int = 2
    
//    var computed: Int {
//        get {
//            return pNum
//        }
//        set {
//            pNum = newValue
//        }
//    }
}

class AccessClassViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let ac = AccessClass()
        print(ac.internalNum, ac.fpNum)
        ac.internalNum = 3
        ac.fpNum = 4
        print(ac.internalNum, ac.fpNum)
    }
}
