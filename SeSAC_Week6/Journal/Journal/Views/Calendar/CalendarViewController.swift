//
//  CalendarViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    var tasks: Results<UserJournal>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        calendarConfig()
        allCountLabelConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = localRealm.objects(UserJournal.self)
        calendarView.reloadData()
    }
    
    func viewConfig() {
        title = CalendarLocalizableString.navigation_title.localized
    }
    
    func calendarConfig() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    func allCountLabelConfig() {
        let allCount = getAllDiaryCountFromUserDiary()
        allCountLabel.text = "총 \(allCount)개를 썼다."
        
        let recent = localRealm.objects(UserJournal.self).sorted(byKeyPath: "writeDate", ascending: false).first?.title
        
        let full = localRealm.objects(UserJournal.self).filter("content != nil").count
        
        let favorite = localRealm.objects(UserJournal.self).filter("favorite == false")
        
        let search = localRealm.objects(UserJournal.self).filter("title == 'gg' OR content CONTAINS[c] '내용'")
        
        print(recent)
        print(full)
        print(favorite)
        print(search)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "title"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "subtitle"
//    }
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
    
    // Date: 시분초까지 모두 동일해야한다.
    // case 1. 영국 표준시 기준으로 표기
    // case 2. DateFormatter 사용
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let test = "20211103"
//
//        if format.date(from: test) == date {
//            return 1
//        }
//        return 0
        
        // 11월 2일에 3개의 일기라면 점 3개. 없으면 점 0개. 1개면 점 1개
        // 시분초까지 완전히 동일해야 표시가된다. print로 tasks를 찍어봐서 확인필수
        return tasks.filter("writeDate == %@", date).count
        
    }
    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        <#code#>
//    }
}
