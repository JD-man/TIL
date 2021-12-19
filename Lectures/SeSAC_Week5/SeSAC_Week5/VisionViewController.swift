//
//  VisionViewController.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/27.
//

import UIKit
import JGProgressHUD

/*
 카메라: 시뮬레이터 테스트 불가능 -> 런타임 오류 발생
 - ImagePickerViewController -> PHPickerViewController
 */

class VisionViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    // ProgressHUD : 언제 보여주고 언제 감출지 정해야함.
    let progress = JGProgressHUD(style: .dark)
    let imagePicker = UIImagePickerController()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.textLabel.text = "Loading"
        
        // photoLibrary는 접근권한을 물어보지않는다.
        imagePicker.sourceType = .photoLibrary
        //imagePicker.sourceType = .camera
        
        // 이미지 편집가능여부
        // True면 infokey는 editedImage 사용해야함
        // false면 infokey는 originalImage 사용해야함
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
    }
    
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        progress.show(in: view, animated: true)
        visionAPIManager.shared.fetchFaceData(image: postImageView.image!) { statusCode, json in
            self.progress.dismiss(animated: true)
            print(json)
        }
    }
    
    
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
}

extension VisionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 사진을 촬영하거나, 갤러리에서 사진을 선택한 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 1. 선택한 사진 가져오기
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // 2. ImageView에 선택한 사진 보여주기
            postImageView.image = value
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 취소했을때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        print(#function)
    }
}
