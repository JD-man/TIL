//
//  UIView+Ext.swift
//  WeatherByVIPER
//
//  Created by JD_MacMini on 2022/04/02.
//

import UIKit

extension UIView {
    func addCorner(rad: CGFloat, borderColor: UIColor?) {
        layer.borderWidth = 1
        layer.cornerRadius = rad
        layer.borderColor = (borderColor ?? .clear).cgColor
    }
}
