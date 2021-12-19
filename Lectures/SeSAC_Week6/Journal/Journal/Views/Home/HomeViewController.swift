//
//  HomeViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeTabbarButtonItem: UITabBarItem!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 20),
        Array(repeating: "c", count: 20),
        Array(repeating: "d", count: 20),
        Array(repeating: "e", count: 20),
        Array(repeating: "f", count: 20),
        Array(repeating: "g", count: 20),
        Array(repeating: "h", count: 20),
        Array(repeating: "i", count: 20),
        Array(repeating: "j", count: 20),
        Array(repeating: "k", count: 20)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        viewConfig()
        tableViewConfig()
    }
    
    func viewConfig() {
        title = HomeLocalizableString.navigation_title.localized
        homeTabbarButtonItem.title = HomeLocalizableString.navigation_title.localized
    }
    
    func tableViewConfig() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.data = array[indexPath.row]
        cell.categoryLabel.text = "\(array[indexPath.row])"
        cell.categoryLabel.backgroundColor = .black
        
                
        cell.collectionView.tag = indexPath.row        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
}


