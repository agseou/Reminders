//
//  AddDetailViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit

struct Item {
    var title: String?
    var isExpanded: Bool?
}

class AddDetailViewController: BaseViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let urlTextField = UITextField()
    var items: [Item] = [Item(title: "날짜", isExpanded: false),
                         Item(title: "시간", isExpanded: false),
                         Item(title: "태그", isExpanded: nil),
                         Item(title: "위치", isExpanded: false),
                         Item(title: "깃발", isExpanded: false),
                         Item(title: "우선순위", isExpanded: nil),
                         Item(title: "이미지추가", isExpanded: false),
                         Item(title: "URL", isExpanded: nil),]

    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dateCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tagCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "flagCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "priorityCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addImageCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "urlCell")
    }

    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension AddDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items[section].isExpanded! ? 3 : 2
        } else {
            return items[section].isExpanded ?? false ? 2 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath == IndexPath(row: 0, section: 0){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dateCell")
            cell.textLabel?.text = "날짜"
            cell.accessoryView = UISwitch()
            
            
        } else if indexPath == IndexPath(row: 1, section: 0){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dateCell")
            cell.textLabel?.text = "시간"
            cell.accessoryView = UISwitch()
            
        } else if indexPath == IndexPath(row: 0, section: 1){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tagCell")
            cell.textLabel?.text = "태그"
            cell.accessoryType = .disclosureIndicator
            
        } else if indexPath == IndexPath(row: 0, section: 2){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "locationCell")
            cell.textLabel?.text = "위치"
            cell.accessoryView = UISwitch()
            
        } else if indexPath == IndexPath(row: 0, section: 3){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "flagCell")
            cell.textLabel?.text = "깃발"
            cell.accessoryView = UISwitch()
            
        } else if indexPath == IndexPath(row: 0, section: 4){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "priorityCell")
            cell.textLabel?.text = "우선순위"
            cell.accessoryType = .disclosureIndicator
            
        } else if indexPath == IndexPath(row: 0, section: 5){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "addImageCell")
            cell.textLabel?.text = "이미지 추가"
            
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "urlCell")
            cell.selectionStyle = .none
            cell.contentView.addSubview(urlTextField)
            urlTextField.placeholder = "URL"
            urlTextField.snp.makeConstraints {
                $0.horizontalEdges.equalTo(cell.contentView).inset(20)
                $0.height.equalTo(40)
                $0.verticalEdges.equalTo(cell.contentView)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 1){
            let vc = UINavigationController(rootViewController: AddTagViewController())
            present(vc, animated: true)
        }
    }
    
}

