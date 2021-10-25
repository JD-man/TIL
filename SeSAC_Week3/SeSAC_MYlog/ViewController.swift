//
//  ViewController.swift
//  SeSAC_MYlog
//
//  Created by JD_MacMini on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Modal: Present - Dismiss
    @IBAction func memoButtonClicked(_ sender: UIButton) {
        // 1. 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 컨트롤러 중, 전환하고자 하는 뷰컨트롤러
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoTableViewController") as! MemoTableViewController
        
        // 2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        // (옵션)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        // 3. Present
        present(nav, animated: true, completion: nil)
        
    }
    
    
    // Push - Pop
    @IBAction func boxOfficeButtonClicked(_ sender: UIButton) {
        // 1. 스토리보드 특정
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 컨트롤러 중, 전환하고자 하는 뷰컨트롤러
        // 화면이 동일한 스토리보드에 있을때 self.storyboard? 사용가능.
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        
        // pass data 3
        vc.titleSpace = "박스오피스"
        
        
        // 3. push
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

