//
//  MainActivateButton.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

@IBDesignable
class MainActivateButton: UIButton {
    
    // Inspector -> User Define Runtime Attribute에 표시됨
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // border color는 CGColor이지만 UIColor로 받고 변경해야함
    @IBInspectable
    var borderColer: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .link
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
