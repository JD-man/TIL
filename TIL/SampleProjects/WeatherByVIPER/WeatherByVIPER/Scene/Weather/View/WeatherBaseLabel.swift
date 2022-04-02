//
//  BaseLabel.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/02.
//

import UIKit

final class WeatherBaseLabel: UILabel {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    convenience init() {
        self.init(frame: .zero)
        viewConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewConfig() {
        clipsToBounds = true
        backgroundColor = .systemBackground
        addCorner(rad: 5, borderColor: .label)
        text = "Base Label"
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
