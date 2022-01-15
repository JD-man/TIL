//
//  MeTableViewCell.swift
//  SocketChat
//
//  Created by JD_MacMini on 2022/01/13.
//

import UIKit
import SnapKit

class MeTableViewCell: UITableViewCell {
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true        
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        label.backgroundColor = .systemGreen        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func viewConfig() {
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in            
            make.width.equalTo(contentView).multipliedBy(0.8)
            make.trailing.top.bottom.equalTo(contentView).inset(10)
        }
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
