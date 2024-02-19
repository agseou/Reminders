//
//  BaseViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    func configureHierarchy() { }
    func configureView() {
        view.backgroundColor = .secondarySystemBackground
    }
    func configureConstraints() { }
    
}
