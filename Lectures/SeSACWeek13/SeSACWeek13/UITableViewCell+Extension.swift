//
//  UITableViewCell+Extension.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/21.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
