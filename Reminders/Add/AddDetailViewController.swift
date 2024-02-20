//
//  AddDetailViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit

class AddDetailViewController: BaseViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let urlTextField = UITextField()
    // 최신버전 미리알림 따라하기 : 추후 스위치를 추가하여 -> 동적으로 셀 추가 등의 조정!!
    // 방법 찾아서 나눈 View들 한 페이지로 합치기

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
        return section == 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath == IndexPath(row: 0, section: 0){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dateCell")
            cell.textLabel?.text = "날짜"
            cell.accessoryType = .disclosureIndicator
            
        } else if indexPath == IndexPath(row: 1, section: 0){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dateCell")
            cell.textLabel?.text = "시간"
            cell.accessoryType = .disclosureIndicator
            
        }else if indexPath == IndexPath(row: 0, section: 1){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tagCell")
            cell.textLabel?.text = "태그"
            cell.accessoryType = .disclosureIndicator
            
        }else if indexPath == IndexPath(row: 0, section: 2){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "locationCell")
            cell.textLabel?.text = "위치"
            cell.accessoryType = .disclosureIndicator
            
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
            urlTextField.snp.makeConstraints {
                $0.horizontalEdges.equalTo(cell.contentView).inset(10)
                $0.verticalEdges.equalTo(cell.contentView)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            let vc = DatePickerViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath == IndexPath(row: 0, section: 5) {
            let vc = ImagePickerViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

