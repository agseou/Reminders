//
//  DateViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/23.
//

import UIKit
import SnapKit

class AddDateViewController: BaseViewController {
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NotificationCenter.default.post(name: Notification.Name("didSelectDate"), object: nil, userInfo: ["selectedDate": datePicker.date])
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureView() {
        super.configureView()
        
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(tapCancelButton))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapCompleteButton))
        navigationItem.rightBarButtonItem = completeBarButtonItem
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints {
            $0.center.equalTo(view)
        }
    }
    
    @objc func tapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapCompleteButton() {
        NotificationCenter.default.post(name: Notification.Name("Date"), object: nil, userInfo: ["selectedDate": datePicker.date])
        navigationController?.popViewController(animated: true)
    }
}
