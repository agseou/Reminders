//
//  AddPriorityViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/23.
//

import UIKit
import SnapKit

class AddPriorityViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var seleted: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    var list: [String] = ["없음" , "높음", "중간", "낮음"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        view.backgroundColor = .white
        
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(tapCancelButton))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapCompleteButton))
        navigationItem.rightBarButtonItem = completeBarButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func tapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapCompleteButton() {
        NotificationCenter.default.post(name: Notification.Name("Priority"), object: nil, userInfo: ["selectedPriority": seleted])
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddPriorityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = list[indexPath.row]
        if indexPath.row == seleted {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seleted = indexPath.row
    }
}
