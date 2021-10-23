//
//  BoxOfficeCastViewController.swift
//  SeSAC_MYlog
//
//  Created by JD_MacMini on 2021/10/15.
//

import UIKit

class BoxOfficeCastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var castTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castTableView.delegate = self
        castTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "CAST \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
