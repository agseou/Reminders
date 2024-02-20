//
//  AddViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit

class AddViewController: BaseViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let titleTextField = UITextField()
    let memoTextField = UITextView()
    let repository = ReminderRepository()
    let date: Date? = nil
    let tag: String? = nil
    let priority: Int? = nil
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }

    override func configureView() {
        super.configureView()
        
        navigationItem.title = "새로운 미리 알림"
        
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(tapCancelButton))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let addBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(tapAddButton))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        tableView.sectionHeaderHeight = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "titleCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "memoCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func tapAddButton() {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        guard let memo = memoTextField.text, !memo.isEmpty else { return }
        guard let date = date else { return }
        guard let tag = tag else { return }
        guard let priority = priority else { return }
        
        let data = ReminderModel(title: title, compelete: false, flag: false)
        ReminderModel(title: title, memo: memo, regDate: Date(), finalDate: date, tags: tag, priority: priority, compelete: false, flag: false)
        
        repository.createItem(data)
        
        dismiss(animated: true)
    }
}


extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath == IndexPath(row: 0, section: 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            cell.contentView.addSubview(titleTextField)
            titleTextField.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(10)
                $0.verticalEdges.equalToSuperview()
            }
            
            cell.selectionStyle = .none
        } else if indexPath == IndexPath(row: 1, section: 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.contentView.addSubview(memoTextField)
            memoTextField.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(10)
                $0.verticalEdges.equalToSuperview()
            }
            
            cell.selectionStyle = .none
        } else if indexPath == IndexPath(row: 0, section: 1) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "detailCell")
            cell.textLabel?.text = "세부사항"
            cell.accessoryType = .disclosureIndicator
            
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "listCell")
            cell.textLabel?.text = "목록"
            cell.accessoryType = .disclosureIndicator
        }
       
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = AddDetailViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
