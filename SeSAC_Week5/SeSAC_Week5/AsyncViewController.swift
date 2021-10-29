//
//  AsyncViewController.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/29.
//

import UIKit

class AsyncViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var labels: [UILabel]!
    
    let url = "https://images.pexels.com/photos/1518500/pexels-photo-1518500.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 내일날짜 구하기
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.dateFormat = "yyyy-MM-dd hh-mm-ss"
        
        
        
        let tomorrow = calendar.date(byAdding: .day, value: -1, to: Date())
        print(formatter.string(from: tomorrow!))
        
        // 2. 이번주 월요일
        var component = calendar.dateComponents([.hour,.minute,.weekday, .weekOfYear, .yearForWeekOfYear], from: Date())
        component.weekday = 2
        let mondayWeek = calendar.date(from: component)
        print(formatter.string(from: mondayWeek!))
        
        labels.forEach { $0.setBorderStyle() }
    }
    
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        DispatchQueue.global().async {
            if let url = URL(string: self.url),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }                
            }
        }
    }
}
