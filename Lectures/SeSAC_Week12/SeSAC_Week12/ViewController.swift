//
//  ViewController.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenView.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(greenView)
        
        
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue
        greenView.backgroundColor = .green
        
        greenView.clipsToBounds = true
        greenView.alpha = 0.5
        
        redView.frame = CGRect(x: 30, y: 30, width: 200, height: 200)
        blueView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        greenView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.subviews[0].backgroundColor = .systemPink
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
    }

    @IBAction func presentButtonClicked(_ sender: UIButton) {
        present(DetailViewController(), animated: true, completion: nil)
    }
}

