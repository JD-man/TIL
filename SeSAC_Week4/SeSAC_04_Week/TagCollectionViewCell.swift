//
//  TagCollectionViewCell.swift
//  SeSAC_04_Week
//
//  Created by JD_MacMini on 2021/10/19.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"
    
    @IBOutlet weak var tagLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
