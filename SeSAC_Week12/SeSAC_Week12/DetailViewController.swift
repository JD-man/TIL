//
//  DetailViewController.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let captionLabel = UILabel()
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        [titleLabel, captionLabel, activateButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setTitleLabelConstraints()
        setCaptionLabelConstraints()
        setActivateButtonConstaints()
    }
    
    func setActivateButtonConstaints() {
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 300),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setTitleLabelConstraints() {
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.backgroundColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        //NSLayoutConstraints
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
    }
    
    func setCaptionLabelConstraints() {
        captionLabel.text = "맞춤 정보를 알려드려요"
        captionLabel.backgroundColor = .lightGray
        captionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        captionLabel.textAlignment = .center
        captionLabel.numberOfLines = 0
        
        let topConstraints = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let centerConstraints = NSLayoutConstraint(item: captionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: captionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 0.7, constant: 0)
        let height = NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.7, constant: 30)
        view.addConstraints([topConstraints, centerConstraints, width, height])
    }
}
