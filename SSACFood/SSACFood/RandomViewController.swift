//
//  RandomViewController.swift
//  SSACFood
//
//  Created by JD_MacMini on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {
    
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    
    let segment: UISegmentedControl = {
        let sc = UISegmentedControl()
        
        return sc
    }()
    
    // 뷰컨트롤러 생명주기
    // 화면이 사용자에게 보이기 직전에 실행되는 기능
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "안녕하세요\n반갑습니다"
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .systemRed
        resultLabel.numberOfLines = 2
        resultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        resultLabel.textColor = UIColor.blue
        resultLabel.layer.cornerRadius = 10
        resultLabel.clipsToBounds = true
        
        checkButton.backgroundColor = UIColor.magenta
        checkButton.setTitle("행운의 숫자를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽑아 뽑아", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(UIColor.white, for: .normal)
        checkButton.setTitleColor(UIColor.gray, for: .highlighted)
    }
    
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let number = Int.random(in: 1 ... 100)
        resultLabel.text = "행운의 숫자는 \(number)입니다."
    }
    
    
}
