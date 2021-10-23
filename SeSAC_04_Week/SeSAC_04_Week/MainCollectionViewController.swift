//
//  MainCollectionViewController.swift
//  SeSAC_04_Week
//
//  Created by JD_MacMini on 2021/10/19.
//

import UIKit

class MainCollectionViewController: UIViewController {
    
    // 1.

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = [Bool](repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        let mainNibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(mainNibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        let tagNibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(tagNibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        //let width = (view.bounds.width - 2 * spacing) / 3 - spacing / 1.5
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tagLayout.minimumInteritemSpacing = tagSpacing
        tagCollectionView.collectionViewLayout = tagLayout
    }
    
    @objc func heartButtonClicked(selectButton: UIButton) {
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
        mainCollectionView.reloadItems(at: [IndexPath(item: selectButton.tag, section: 0)])
        //mainArray[selectButton.tag].toggle()
    }
}


extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return 10
        }
        else {
            return mainArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.mainImageView.backgroundColor = .systemPink
            
            let item = mainArray[indexPath.item]
            let image = item ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton:)), for: .touchUpInside)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.tagLabel.text = "안녕하세요"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            return cell
        }
    }
}
