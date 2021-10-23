//
//  WebViewController.swift
//  SeSAC_04_Week
//
//  Created by JD_MacMini on 2021/10/19.
//

import UIKit

// for using WKWebView
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var urlSearchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlSearchBar.delegate = self
    }
}


extension WebViewController: UISearchBarDelegate {
    
    // 서치바에서 검색 리턴키 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // http vs https
        guard let url = URL(string: "https://" + (searchBar.text ?? "")) else {
            print("url error")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
