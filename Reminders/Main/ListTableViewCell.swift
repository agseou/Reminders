//
//  ListTableViewCell.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit

class ListTableViewCell: BaseTableViewCell {
    
    let data = ReminderModel()
    let checkButton = UIButton()
    let stackView = UIStackView()
    let titleStackView = UIStackView()
    let priorityMark = UILabel()
    let titleLabel = UILabel()
    let flagMark = UIImageView(image: UIImage(systemName: "flag.fill"))
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    let tagLabel = UILabel()
    let urlButton = UIButton()
    let imageViews = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(checkButton)
        contentView.addSubview(stackView)
        stackView.addSubview(titleStackView)
        
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(memoLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(urlButton)
        stackView.addArrangedSubview(imageViews)
        
        titleStackView.addArrangedSubview(priorityMark)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(flagMark)
        
    }
    
    override func configureView() {
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        titleStackView.axis = .horizontal
        titleStackView.alignment = .leading
        titleStackView.distribution = .fill
        titleStackView.spacing = 4
        
        titleLabel.text = data.title
        titleLabel.text = "test"
        
        memoLabel.text = data.memo
        memoLabel.text = "testmemo"
        
        dateLabel.text = data.date?.formattedDate
        dateLabel.text = Date().formattedDate
    }
    
    override func configureConstraints() {
        checkButton.snp.makeConstraints {
            $0.left.top.equalTo(contentView).offset(10)
            $0.size.equalTo(44)
        }
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.left.equalTo(checkButton.snp.right)
            $0.right.equalTo(contentView)
        }
    }
}
