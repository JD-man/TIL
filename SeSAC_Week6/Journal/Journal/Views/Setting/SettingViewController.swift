//
//  SettingViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit
import Zip
import MobileCoreServices

/*
 백업하기
 - 사용자의 아이폰 저장 공간 확인
    - 부족: 백업 불가
 - 백업 진행
    - 어떤 데이터도 없는 경우라면 백업할 데이터가 없다고 안내
    - 백업 가능한 파일 여부 확인. realm, folder
    - Progress + UI 인터렉션 금지
- zip
    - 백업 완료 시점에 UI 인터렉션 허용
- 공유화면
 */

/*
 복구하기
 - 저장 공간 확인
 - 파일 앱
    - zip 파일 확인
    - zip 선택
 - zip -> unzip
    - 백업 파일 이름 확인
    - 압축 해제
        - 백업 파일 확인: 폴더, 파일 이름 확인
        - 정상적인 파일이 아니면 얼럿
 
 
 */

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    // 1. Document 위치
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        }
        else {
            return nil
        }
    }
    
    func viewConfig() {
        title = SettingLocalizableString.navigation_title.localized
    }
    
    // 공유
    func presentActivityViewController() {
        // 압축파일경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL],
                                          applicationActivities: [])
        
        present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        // 4. 백업 파일에 대한 URL 배열
        var urlPaths = [URL]()
        
        // 1. Document 위치
        if let path = documentDirectoryPath() {
            // 2. 백업 파일 URL 확인
            // 이미지 같은 경우 폴더를 생성하고 폴더 경로를 사용하는것이 좋다.
            let realm = (path as NSString).appendingPathComponent("default.realm")
            // 3. 백업 파일 존재 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. URL 배열에 백업 파일 URL 추가
                urlPaths.append(URL(string: realm)!)
                
                do {
                    // 3. 백업
                    let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
                    print("압축 경로 : \(zipFilePath)")
                    presentActivityViewController()
                }
                catch {
                  print("Something went wrong")
                }
                
            }
            else {
                print("백업할 파일이 없습니다.")
            }
        }
    }
    
    
    @IBAction func activityButtonClicked(_ sender: UIButton) {
        presentActivityViewController()
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        // 복구 1. 파일앱 열기 + 확장자
        // import MobileCoreServices
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        //let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        // 복구 2. 선택한 파일에 대한 경로를 가져와야한다.
        guard let selectedFileURL = urls.first else { return }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            // 복구하고자 하는 zip 파일을 이미 가지고 있는 경우, 그 zip 파일을 해제한다.
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                let _ = try Zip.unzipFile(fileURL,
                                                       destination: documentDirectory,
                                                       overwrite: true,
                                                       password: nil,
                                                       progress: { progress in
                    print("progress: \(progress)")
                    // 복구가 완료되었습니다 또는 재시작 메세지,얼럿.
                },
                                                       fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            }
            catch {
                print(error)
            }
        }
        
        // zip파일이 이미 없는 경우
        else {
            // 파일 앱의 zip 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                let _ = try Zip.unzipFile(fileURL,
                                                       destination: documentDirectory,
                                                       overwrite: true,
                                                       password: nil,
                                                       progress: { progress in
                    print("progress: \(progress)")
                    // 복구가 완료되었습니다 또는 재시작 메세지,얼럿.
                },
                                                       fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            }
            catch {
                print(error)
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
}
