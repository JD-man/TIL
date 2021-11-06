# Backup/Restore

## 백업하기
- [Zip](https://github.com/marmelroy/Zip) 라이브러리를 사용해 압축
- 과정
1. 앱의 Document 폴더 경로 얻기
2. Document 폴더의 realm 파일 경로 얻기
3. realm 경로를 이용해 압축파일 생성
4. ActivityViewController에 생성한 압축파일의 경로를 이용해 공유하기 사용

```swift
@IBAction func backupButtonClicked(_ sender: UIButton) {
    var urlPaths = [URL]()
    // 1.
    if let path = documentDirectoryPath() {        
        // 2.
        let realm = (path as NSString).appendingPathComponent("default.realm")
        if FileManager.default.fileExists(atPath: realm) {            
            urlPaths.append(URL(string: realm)!)            
            do {                
                // 3.
                let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive")                
                // 4.
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

func presentActivityViewController() {
    // 생성한 zip 파일명이 같아야 한다.
    let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
    let fileURL = URL(fileURLWithPath: fileName)
    let vc = UIActivityViewController(activityItems: [fileURL],
                                      applicationActivities: [])
    
    present(vc, animated: true, completion: nil)
}
```

## 복구하기
- UIDocumentPickerViewController와 Delegate 사용
- [Zip](https://github.com/marmelroy/Zip) 라이브러리를 사용해 압축해제
- 과정
1. Delegate의 didPickDocumentAt을 이용해 선택한 파일의 URL 가져오기
2. Document 경로에 위의 경로 중 lastPathComponent를 append
3. 파일이 이미 있는 경우는 그 파일을 압축해제
4. 파일이 없는 경우 복사해서 압축해제

```swift
@IBAction func restoreButtonClicked(_ sender: UIButton) {
    // 1.
    let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)            
    documentPicker.delegate = self

    documentPicker.allowsMultipleSelection = false
    present(documentPicker, animated: true, completion: nil)
}

extension SettingViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // 2.
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 3. Zip 파일이 이미 존재
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                let _ = try Zip.unzipFile(fileURL,
                                                        destination: documentDirectory,
                                                        overwrite: true,
                                                        password: nil,
                                                        progress: { progress in
                    print("progress: \(progress)")                    
                },
                                                       fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            }
            catch {
                print(error)
            }
        }
        
        // 4. Zip 파일이 이미 없음
        else {            
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
}
```
