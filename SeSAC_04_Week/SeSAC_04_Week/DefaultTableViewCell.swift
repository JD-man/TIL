//
//  DefaultTableViewCell.swift
//  SeSAC_04_Week
//
//  Created by JD_MacMini on 2021/10/18.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    static let identifier = "DefaultTableViewCell"

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
