//
//  DetailViewController.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    let bannerView = BannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(bannerView)
        view.backgroundColor = .systemPink
        bannerView.frame = CGRect(x: 30, y: 120, width: UIScreen.main.bounds.width - 60, height: 120)
        bannerView.backgroundColor = .systemTeal
    }
}
