//
//  PPGViewController.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class PPGViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id" : naverClientID,
            "X-Naver-Client-Secret" : naverClientSecret
        ]
        
        let parameters = [
            "source" : "ko",
            "target" : "en",
            "text" : sourceTextView.text!
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
