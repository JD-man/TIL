//
//  ContentViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let localRealm = try! Realm()
    
    // MARK: - Functions when viewDidLoad
    override func viewDidLoad() {
        print("realm is locaed at:", localRealm.configuration.fileURL!)
        
        viewConfig()
        titleTextFieldConfig()
        dateButtonConfig()
        contentTextViewConfig()
        saveButtonConfig()
        super.viewDidLoad()
    }
    
    func viewConfig() {
        title = ContentLocalizableString.navigation_title.localized
    }
    
    func titleTextFieldConfig() {
        titleTextField.font = UIFont.nanumSquareRoundBold(size: 15)
        titleTextField.placeholder = ContentLocalizableString.titleTextField_placeholder.localized
        
        titleTextField.autocorrectionType = .no
        titleTextField.autocapitalizationType = .none
    }
    
    func dateButtonConfig() {
        dateButton.titleLabel?.font = UIFont.nanumSquareRoundRegular(size: 15)
    }
    
    func contentTextViewConfig() {
        contentTextView.font = UIFont.nanumSquareRoundRegular(size: 16)
        contentTextView.text = ContentLocalizableString.contentTextView_placeholder.localized
        
        contentTextView.autocorrectionType = .no
        contentTextView.autocapitalizationType = .none
        
        contentTextView.delegate = self
    }
    
    func saveButtonConfig() {
        saveButton.title = ContentLocalizableString.saveButton_title.localized
    }
    
    // MARK: - IBActions of Bar Button Item
    @IBAction func exitButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
//        let format = DateFormatter()
//        format.dateFormat = "yyyy년 MM월 dd일"
        
        guard let date = dateButton.currentTitle,
              let value = DateFormatter.customFormat.date(from: date) else {
                  return
              }
        
        // save journal
        let task = UserJournal(title: titleTextField.text!,
                               content: contentTextView.text,
                               writeDate: value,
                               regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).png",
                                         image: contentImageView.image!)
        }
        //dismiss(animated: true, completion: nil)
        
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 1. 이미지 저장 경로 설정: Document
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                  in: .userDomainMask).first else {
            return
        }
        print("Document Path:", documentDirectory)
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        guard let data = image.pngData() else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기가 됨.
        // 4-1. 이미지 경로 존재여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            // 4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(atPath: imageURL.path)
                print("이미 있는 이미지 삭제 성공")
            }
            catch {
                print("이미 있는 이미지 삭제 실패")
            }
        }
        
        // 5. 이미지를 저장
        do {
            try data.write(to: imageURL)
            print("새 이미지 저장 성공")
        }
        catch {
            print("새 이미지 저장 실패")
        }
        
    }
    
    
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        
        guard let contentView = storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {
            print("DatePickerViewController에 오류")
            return
        }
        contentView.preferredContentSize = CGSize(width: view.bounds.width/2, height: view.bounds.height/5)
        alert.setValue(contentView, forKey: "contentViewController")
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            
            // 확인 버튼 눌렀을때 버튼 타이틀 변경
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePickerView.date)
            
            sender.setTitle("\(value)", for: .normal)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension AddViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.text = ContentLocalizableString.contentTextView_placeholder.localized
        }
    }
}
