//
//  TagCollectionViewCell.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/22.
//

import UIKit
import SnapKit

class TagCollectionViewCell: BaseCollectionViewCell {
    
    let tagButton = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(tagButton)
    }
    
    override func configureView() {
        var config = UIButton.Configuration.gray()
        tagButton.configuration = config
    }
    
    override func configureConstraints() {
        tagButton.snp.makeConstraints {
            $0.edges.equalTo(contentView)
            $0.height.equalTo(40)
        }
    }
}
