//
//  DatePickerViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit

class DatePickerViewController: BaseViewController {

    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
     
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureView() {
        super.configureView()
        
    
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
