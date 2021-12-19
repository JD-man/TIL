//
//  SearchViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserJournal>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        searchTableViewConfig()
    }
    
    func viewConfig() {
        title = SearchLocalizableString.navigation_title.localized
    }
    
    func searchTableViewConfig() {
        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        searchTableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get all tasks in the realm
        tasks = localRealm.objects(UserJournal.self)
        searchTableView.reloadData()
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                  in: .userDomainMask).first else {
            return
        }
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(atPath: imageURL.path)
                print("이미지 삭제 성공")
            }
            catch {
                print("이미지 삭제 실패")
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                 for: indexPath) as! SearchTableViewCell
        let row = tasks[indexPath.row]
        cell.configure(with: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
       
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let task = tasks[indexPath.row]
        
        try! localRealm.write {
            deleteImageFromDocumentDirectory(imageName: "\(task._id).png")
            localRealm.delete(task)
            tableView.reloadData()            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToUpdate = tasks[indexPath.row]
        
        // 1. 레코드에 대한 값 수정
//        try! localRealm.write {
//            taskToUpdate.title = "우왕굳2"
//            taskToUpdate.content = "굳왕우2"
//            tableView.reloadData()
//        }
        
        // 2. 일괄수정
        
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "writeDate")
//            tableView.reloadData()
//        }
        
        // 3. 수정: pk 기준으로 사용 (권장X), 변경값 외에는 전부 초기화, 날짜는 전부 최신으로 변경
        
//        try! localRealm.write {
//            let update = UserJournal(value: ["_id" : taskToUpdate._id, "title": "타이틑 변경"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        // 4. 수정 : 원하는거만 수정
        try! localRealm.write {
            localRealm.create(UserJournal.self,
                              value: ["_id" : taskToUpdate._id, "title": "타이틑 변경3"],
                              update: .modified)
            tableView.reloadData()
        }
    }
}
