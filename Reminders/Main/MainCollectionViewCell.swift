//
//  MainCollectionViewCell.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit

class MainCollectionViewCell: BaseCollectionViewCell {
    
    let view = UIView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    let iconView = ListIcon()
    
    override func configureHierarchy() {
        contentView.addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(countLabel)
        view.addSubview(iconView)
    }
    
    override func configureView() {
        view.backgroundColor = .white
        DispatchQueue.main.async {
            self.view.layer.cornerRadius = 10
        }
       
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .secondaryLabel
        
        countLabel.text = "0"
        countLabel.font = .systemFont(ofSize: 24, weight: .bold)
        countLabel.textColor = .label
    }
    
    override func configureConstraints() {
        view.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        iconView.snp.makeConstraints {
            $0.top.left.equalTo(view).offset(10)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(view).offset(10)
            $0.bottom.equalTo(view).inset(10)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(10)
            $0.right.equalTo(view).inset(15)
        }
    }
    
}
