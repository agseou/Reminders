//
//  BaseTableViewCell.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configureHierarchy() { }
    func configureView() { }
    func configureConstraints() { }
}
