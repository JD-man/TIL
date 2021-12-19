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
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        // OpenWeatherLink       
        let url = Endpoint.weatherURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print("JSON: \(json)")
                
                // main의 weather
                
                // OpenWeather의 온도는 K
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                let windSpeed = json["wind"]["speed"].doubleValue
                let humidity = json["main"]["humidity"].intValue
                
                self.currentTempLabel.text = "\(Int(currentTemp))℃"
                self.windSpeedLabel.text = "\(Int(windSpeed))m/s"
                self.humidityLabel.text = "\(humidity)"
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

