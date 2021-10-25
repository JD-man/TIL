//
//  DateViewController.swift
//  SeSACEmotionDiary
//
//  Created by JD_MacMini on 2021/10/07.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        // DatePicker가 가지고 있는 날짜
        print(sender.date)
        
        // DateFormatter: 날짜를 원하는 형태로 변환
        // 1. DateFormat, 2. 한국시간
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh-mm"
        
        // 스마트폰의 지역설정을 가져오기
        format.locale = Locale(identifier: Locale.current.identifier)
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        let value = format.string(from: sender.date)
        print(value)
        
        // 100일 뒤의 날짜
        // TimeInterval은 초단위, 하루는 86400초(24시간 * 60분 * 60초)
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print("D-100 : " + format.string(from: afterDate))
    }
}
