//
//  TempViewController.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/24.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //ctrl + shift: 여러 다른곳에서 작성하기(클릭 또는 방향키)
        //cmd + opt: 줄바꾸기
        print("hello")
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ctrl + shift: 여러 다른곳에서 작성하기(클릭 또는 방향키)
        print(#function)
    }
    
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ctrl + shift: 여러 다른곳에서 작성하기(클릭 또는 방향키)
        print(#function)
    }
    
    
    // opt+cmd+/ 설명생성
    
    /// 우왕
    /// - Parameter animated: 굳
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //ctrl + shift: 여러 다른곳에서 작성하기(클릭 또는 방향키)
        print(#function)
    }
    
    /// - parameters meassage: 파라미터
    /// - important: 중요사항
    /// - returns: string
    /// - 사용자 정보
    /// - 닉네임 : 최소 3자 이상 8자까지 가능. **숫자 불가**
    func welcome(message: String, completion: @escaping () -> Void) -> String {
        return ""
    }
    
}



class User {
    var name: String
    var age: Int
    var email: String
    var review: Double
    
    init(name: String, age: Int, email: String, review: Double) {
        self.name = name
        self.age = age
        self.email = email
        self.review = review
    }
}


