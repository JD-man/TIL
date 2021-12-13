//
//  SquareBoxView.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

class SquareBoxView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("SquareBoxView override init")
    }
    
    func loadView() {
        // Bundle.main.loadNibNamed 보다 늦게나옴. 캐싱처리가 있어서 UINib을 이용하는게 더 빠르다
        let view2 = Bundle.main.loadNibNamed("SquareBoxView", owner: self, options: nil)!.first as! UIView
        
        //let view = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view2.frame = bounds
        view2.backgroundColor = .gray
        view2.layer.cornerRadius = 10
        addSubview(view2)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "마이페이지"
        label.textAlignment = .center
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
}









