//
//  WeatherBaseImageView+RxExt.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/03.
//

import Foundation
import RxSwift
import Kingfisher

extension Reactive where Base: WeatherBaseImageView {
    var iconImage: Binder<String> {
        return Binder(self.base) { imageView, iconName in
            imageView.kf.setImage(with: URLComponents.getStatusImageURL(of: iconName))
        }
    }
}
