//
//  SignViewModel.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/22.
//

import UIKit

class SignViewModel {
    var navigationTitle: String = "Title"
    var buttonTitle: String = "Sign"
    
    
    // filepravate는 다른 파일에서 사용할 수 없음
    fileprivate func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    
    var text: String = "Email?" {
        didSet {
            let count = text.count
            let value = count >= 10 ? "작성할 수 없습니다" : "\(count)/10"
            let color: UIColor = count > 10 ? .red : .black
            listener?(value, color)
        }
    }
    
    // Generic으로 만든다면????????????????!!!!!!!!!!!!!!!
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        self.listener = listener
    }
}
