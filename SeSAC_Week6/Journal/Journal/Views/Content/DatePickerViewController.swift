//
//  DatePickerViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePickerView.preferredDatePickerStyle = .wheels
    }
}
