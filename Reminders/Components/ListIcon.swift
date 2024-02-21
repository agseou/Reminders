//
//  ListIcon.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit

class ListIcon: UIView {

    let circleView = UIView()
    let icon = UIImageView(image: UIImage(systemName: "calendar"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { 
        addSubview(circleView)
        circleView.addSubview(icon)
    }
    func configureView() {
        DispatchQueue.main.async {
            self.circleView.layer.cornerRadius = self.circleView.bounds.width/2
        }
        circleView.backgroundColor = .blue
        icon.tintColor = .white
    }
    func configureConstraints() {
        circleView.snp.makeConstraints {
            $0.edges.equalTo(self)
            $0.size.equalTo(36)
        }
        icon.snp.makeConstraints {
            $0.edges.equalTo(circleView).inset(4)
        }
    }
}
