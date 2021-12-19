//
//  BannerView.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

class BannerView: UIView {
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    // xib 또는 IBOutlet이 없기 때문에 override init 사용
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("BannerView override init")
        loadLayout()
    }
    
    
    // ?가 붙어있는 이니셜라이저 = 실패 가능한 이니셜라이저
    required init?(coder: NSCoder) {        
        fatalError("init(coder:) has not been implemented")
        print("BannerView required init")
    }
    
    func loadLayout() {
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textColor = .black
        mainLabel.text = "내일 오를 주식을 맞춰주세요!"
        
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "맞히면 500원을 드려요"
        
        mainLabel.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 130, height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width - 130, height: 30)
        
        addSubview(mainLabel)
        addSubview(descriptionLabel)
    }
}
