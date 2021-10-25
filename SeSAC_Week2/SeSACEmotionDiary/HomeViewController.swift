//
//  HomeViewController.swift
//  SeSACEmotionDiary
//
//  Created by JD_MacMini on 2021/10/06.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var emotionStackView: UIStackView!
    
    // 스택뷰 배치와 같은 단어 Array. UserDefault의 키와 레이블에 사용된다.
    let words = [
        ["행복해", "사랑해", "좋아해"],
        ["당황해", "속상해", "우울해"],
        ["심심해", "이상해", "슬퍼해"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //UserDefault 초기화 코드
//        let wordsFlat = words.flatMap {$0}
//        for word in wordsFlat {
//            UserDefaults.standard.removeObject(forKey: word)
//        }
        
        // 버튼 설정
        buttonConfig()
    }
    
    
    // 최상위 StackView를 이용해 버튼과 레이블을 설정
    func buttonConfig() {
        for (i, rowStackView) in emotionStackView.subviews.enumerated() {
            for (j, view) in rowStackView.subviews.enumerated() {
                
                // 버튼의 타이틀을 row,col로 정한다. Tint Color는 Clear Color로 안보이게 한다.
                let button = view.subviews[0] as! UIButton
                button.setTitle("\(i),\(j)", for: .normal)
                
                // 레이블 text 설정. words Array를 이용해 UserDefalut에 저장된 value를 가져오고 텍스트로 사용한다.
                let label = view.subviews[1] as! UILabel
                let word = words[i][j]
                let emotionNumber = UserDefaults.standard.integer(forKey: word)
                
                label.text = "\(word) \(emotionNumber)"
            }
        }
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        // viewDidLoad에서 설정한 타이틀을 이용해 터치된 버튼의 타이틀로 row와 col 정보를 가져온다.
        let title = sender.titleLabel?.text?.components(separatedBy: ",")
        let row = Int(title![0])!
        let col = Int(title![1])!
        
        // 해당 버튼위치의 단어
        let word = words[row][col]
        
        // 위의 단어를 이용해 가져온 UserDefalut value. 터치됐으므로 1을 더한다. 그리고 다시 저장한다.
        let emotionNumber = UserDefaults.standard.integer(forKey: word) + 1
        UserDefaults.standard.set(emotionNumber, forKey: word)
        
        // label text를 업데이트한다.
        let rowStackView = emotionStackView.subviews[row]
        let view = rowStackView.subviews[col]
        let label = view.subviews[1] as! UILabel
        
        label.text = "\(word) \(emotionNumber)"
    }
    
}
