//
//  BoxOfficeDetailViewController.swift
//  SeSAC_MYlog
//
//  Created by JD_MacMini on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Pass data 1.
//    var movieTitle: String?
//    var releaseDate: String?
//    var runtime: Int?
//    var overview: String?
//    var rate: Double?
    
    var movieData: Movie?
    
    let pickerList: [String] = ["감자", "고구마", "파인애플", "자두", "복숭아"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleTextField.text = pickerList[row]
    }
    

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overViewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overViewTextView.delegate = self
        
        // TextField InputView
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        titleTextField.inputView = pickerView
        
        overViewTextView.text = "줄거리를 남겨보세요"
        overViewTextView.textColor = .lightGray
        
        titleTextField.text = movieData?.title
        overViewTextView.text = movieData?.overview
        
        print(movieData?.runtime, movieData?.rate, movieData?.releaseDate)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "줄거리를 남겨보세요"
            textView.textColor = .lightGray
        }
    }
}
