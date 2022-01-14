//
//  DetailViewController.swift
//  SeSAC_WEEK16
//
//  Created by JD_MacMini on 2022/01/13.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        if let presentationViewController = presentationController
            as? UISheetPresentationController {
            presentationViewController.detents = [.medium(), .large()]
            presentationViewController.prefersGrabberVisible = true
        }
    }
}
