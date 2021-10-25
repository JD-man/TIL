//
//  MainCollectionViewCell.swift
//  SeSAC_04_Week
//
//  Created by JD_MacMini on 2021/10/19.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }        
}
