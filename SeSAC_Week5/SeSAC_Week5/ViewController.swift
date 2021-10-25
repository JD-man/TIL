//
//  ViewController.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        // OpenWeatherLink       
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

