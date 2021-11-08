//
//  SearchTableViewCell.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    @IBOutlet weak var searchImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchImageViewConfig()
    }
    
    func searchImageViewConfig() {
        searchImageView.layer.masksToBounds = true
        searchImageView.layer.cornerRadius = 10
    }
    
    func configure(with data: UserJournal) {
        titleLabel.text = data.title
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
        dateLabel.text = format.string(from: data.writeDate)
        contentLabel.text = data.content
        searchImageView.image = loadImageFromDocumentDirectory(imageName: "\(data._id).png")
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        else {
            return nil
        }
    }
}
