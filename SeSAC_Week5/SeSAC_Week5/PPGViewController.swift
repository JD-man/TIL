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
    
    var translateText: String = "" {
        didSet {
            targetTextView.text = translateText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        guard let text = sourceTextView.text else { return }
        TranslatedAPIManager.shared.fetchTranslateData(text: text) { statusCode, json in
            switch statusCode {
            case 200:
                self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                self.translateText = json["errorMessage"].stringValue
            default:
                print("오류")
            }
        }
    }
}
