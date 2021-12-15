//
//  SquareBoxView.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

class SquareBoxView: TabAnimtaionView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
//    // 코드 사용시 초기화
//    override init(frame: CGRect) {
//        <#code#>
//    }
    
    // storyboard 사용시 초기화
    // 코드로 UIView를 작성하고 스토리보드에 올리면 여기에 관한 오류가 나온다
    // UIView는 NSCoding 프로토콜 채택: xib -> nib -> compile (아카이빙과정, deserialize 과정)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("SquareBoxView required init")
        loadView()
        loadUI()
    }
    
    
    // 이걸 만들어 놓으면 빈 생성자로 만들 수 있따!!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        loadUI()
    }
    
    func loadView() {
        // Bundle.main.loadNibNamed 보다 늦게나옴. 캐싱처리가 있어서 UINib을 이용하는게 더 빠르다
        let view2 = Bundle.main.loadNibNamed("SquareBoxView", owner: self, options: nil)?.first as! UIView
        //let nibView = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view2.frame = bounds
        view2.backgroundColor = .green
        view2.layer.cornerRadius = 10
        view2.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        addSubview(view2)
    }
    
    func loadUI() {        
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "마이페이지"
        label.textAlignment = .center
        label.backgroundColor = .clear
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
}

class TabAnimtaionView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1
            }
        }
    }
}







