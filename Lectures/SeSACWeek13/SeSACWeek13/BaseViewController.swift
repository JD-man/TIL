//
//  BaseViewController.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/22.
//
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
    }
    
    func configure() {
        view.backgroundColor = .brown
    }
    
    func setupConstraints() {
        
    }
}
