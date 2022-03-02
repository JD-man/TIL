//
//  BeersTableViewCell.swift
//  ExampleReatorKit
//
//  Created by JD_MacMini on 2022/03/02.
//

import UIKit
import SnapKit
import Kingfisher

final class BeersTableViewCell: UITableViewCell {
    static let identifier = "BeersTableViewCell"
    
    private let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewConfig() {
        [beerImageView, nameLabel, taglineLabel, descriptionLabel]
            .forEach { contentView.addSubview($0) }
        
        beerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(beerImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(beerImageView)
            make.top.equalTo(beerImageView.snp.bottom).offset(16)
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(beerImageView)
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(beerImageView)
            make.bottom.equalTo(contentView).offset(-16).priority(.low)
        }
    }
    
    func configure(with data: BeersItemModel) {
        beerImageView.kf.setImage(with: data.imageURL)
        nameLabel.text = data.name
        taglineLabel.text = data.tagline
        descriptionLabel.text = data.description
    }
}
