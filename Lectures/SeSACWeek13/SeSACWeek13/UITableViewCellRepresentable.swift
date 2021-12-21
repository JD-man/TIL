//
//  UITableviewCellRepresentable.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/21.
//

import Foundation
import UIKit

protocol UITableViewCellRepresentable {
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
