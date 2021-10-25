//
//  BoxOfficeTableViewController.swift
//  SeSAC_MYlog
//
//  Created by JD_MacMini on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {
    
    // pass data 1. 값을 전달 받을 공간
    var titleSpace: String?
    
    let movieInformation = MovieInformation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pass data 2. 표현
        title = titleSpace ?? "내용 없을 때 타이틀"
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        // Push - Pop
        // Dismiss X
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInformation.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        let row = movieInformation.movie[indexPath.row]
        
        cell.posterImageView.image = UIImage(named: row.title)
        cell.titleLabel.text = row.title
        cell.releaseDataLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as! BoxOfficeDetailViewController
        
        let row = movieInformation.movie[indexPath.row]
        vc.movieData = row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }

}
