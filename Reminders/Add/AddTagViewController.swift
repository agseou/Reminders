//
//  addTagViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit

class AddTagViewController: BaseViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "insertTagCell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension AddTagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "tagListCell")
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "insertTagCell")
        
        cell.contentView.addSubview(textField)
        textField.placeholder = "새로운 태그 추가..."
        textField.snp.makeConstraints {
            $0.edges.equalTo(cell.contentView)
        }
        
        return cell
    }
    
    
    
}
