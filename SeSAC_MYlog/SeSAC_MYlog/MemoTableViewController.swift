//
//  MemoTableViewController.swift
//  SeSAC_MYlog
//
//  Created by JD_MacMini on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
    var list: [Memo] = [] {
        didSet {
            saveData()
        }
    }

    @IBOutlet weak var categorySegmentedControll: UISegmentedControl!
    @IBOutlet weak var memoTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.text = "메모"
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        loadData()
    }
    
    @objc func leftBarButtonItemClicked() {        
        dismiss(animated: true, completion: nil)
    }
    
    // save button
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        // 배열에 텍스트뷰의 텍스트 값 추가
        if let text = memoTextView.text {
            let category = Category(rawValue: categorySegmentedControll.selectedSegmentIndex) ?? .others
            let memo = Memo(content: text, category: category)
            list.append(memo)
            //tableView.reloadData()
            print(list)
        }
        else {
            print("값없음")
        }
    }
    
    func loadData() {
        let userDefault = UserDefaults.standard
        if let data = userDefault.object(forKey: "memoList") as? [[String : Any]] {
            var memo = [Memo]()
            for datum in data {
                guard let category = datum["category"] as? Int else {
                    // alert
                    return
                }
                guard let content = datum["content"] as? String else {
                    //alert
                    return
                }
                memo.append(Memo(content: content, category: Category(rawValue: category) ?? .others))
            }
            
            list = memo
        }
    }
    
    func saveData() {
        var memo: [[String : Any]] = []
        
        for i in list {
            let data: [String : Any] = [
                "category" : i.category.rawValue,
                "content" : i.content
            ]
            
            memo.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(memo, forKey: "memoList")
        tableView.reloadData()
    }
    
    // 옵션: 섹션의 수: numberOfSection
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 옵션: 섹션 타이틀
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "섹션 0" : "섹션 1"
    }
    
    // 옵션: 스와이프 셀 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 1 {
                list.remove(at: indexPath.row)
                //tableView.reloadData()
            }
        }
    }
    
    // 옵션 : 셀 편집 가능여부 설정
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    // 옵션 : 셀 터치시 동작
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
    }
    
    // 필수 요소
    // 1. 셀의 갯수: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 2
//        }
//        else {
//            return 4
//        }
        
        return section == 0 ? 2 : list.count
    }
    
    // 2. 셀의 디자인 및 데이터 처리 : CellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용 메커니즘에 사용
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "첫번째 섹션입니다. - \(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            
            // 셀 재사용시 초기화
            cell.imageView?.image = nil
            cell.detailTextLabel?.text = nil
        }
        else {
            let row = list[indexPath.row]
            switch row.category {
            case .business:
                cell.imageView?.image = UIImage(systemName: "building.2")
            case .personal:
                cell.imageView?.image = UIImage(systemName: "person")
            case .others:
                cell.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
            cell.imageView?.tintColor = .magenta
            cell.textLabel?.text = row.content
            cell.detailTextLabel?.text = row.category.description
            cell.textLabel?.textColor = .systemIndigo
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        }
        return cell
    }
    
    // 3. 셀의 높이 : heightForRowAt
    // automaticDimension ???????
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 44 : 80
    }
}
