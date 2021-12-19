//
//  PPGViewController.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/26.
//

import UIKit
import Network

import Alamofire
import SwiftyJSON

class PPGViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    var translateText: String = "" {
        didSet {
            targetTextView.text = translateText
        }
    }
    
    // 네트워크 변경 감지 클래스
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network Conneted")
                
                if path.usesInterfaceType(.cellular) {
                    print("using cellular data")
                }
                else if path.usesInterfaceType(.wifi) {
                    print("using wifi")
                }
                else {
                    print("others")
                }
            }
            else {
                print("Network Disconneted")
            }
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        guard let text = sourceTextView.text else { return }
        
        TranslatedAPIManager.shared.fetchTranslateData(text: text) { statusCode, json in
            switch statusCode {
            case 200:
                DispatchQueue.main.async {
                    self.translateText = json["message"]["result"]["translatedText"].stringValue
                }
            case 400:
                DispatchQueue.main.async {
                    self.translateText = json["errorMessage"].stringValue
                }                
            default:
                print("오류")
            }
        }
    }
}
