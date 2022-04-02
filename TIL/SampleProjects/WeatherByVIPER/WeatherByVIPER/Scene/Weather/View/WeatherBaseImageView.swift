//
//  WeatherBaseImageView.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/02.
//

import UIKit

final class WeatherBaseImageView: UIImageView {
    
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
        image = UIImage(systemName: "person")
    }
}
