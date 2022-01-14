//
//  YouTableViewCell.swift
//  SocketChat
//
//  Created by JD_MacMini on 2022/01/13.
//

import UIKit

class YouTableViewCell: UITableViewCell {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.textAlignment = .left
        label.layer.cornerRadius = 5
        label.backgroundColor = .link
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
            make.leading.equalTo(10)
            make.width.equalTo(contentView).multipliedBy(0.8)
            make.top.bottom.equalTo(contentView).inset(10)            
        }
    }
}
