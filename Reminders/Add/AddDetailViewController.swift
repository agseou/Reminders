//
//  AddDetailViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit
import Toast

class AddDetailViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let urlTextField = UITextField()
    var sender: ((ReminderModel) -> Void)?
    var todo = ReminderModel()
    var isFlagged: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveData), name: NSNotification.Name("Date"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveData), name: NSNotification.Name("Priority"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        sender?(todo)
    }
    
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
    
    @objc func receiveData(_ notification: NSNotification) {
        if let date = notification.userInfo?["selectedDate"] as? Date {
            self.todo.date = date
            tableView.reloadData()
        }
        if let priority = notification.userInfo?["selectedPriority"] as? Int {
            self.todo.priority = priority
            tableView.reloadData()
        }
    }
    
    @objc func flagSwitchChanged(_ sender: UISwitch) {
        self.todo.flag = sender.isOn
    }
}

extension AddDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath == IndexPath(row: 0, section: 0){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dateCell")
            cell.textLabel?.text = "날짜"
            cell.accessoryView = UISwitch()
            
            cell.detailTextLabel?.text = todo.date?.formattedDate ?? nil
            
            //        } else if indexPath == IndexPath(row: 1, section: 0){
            //            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dateCell")
            //            cell.textLabel?.text = "시간"
            //            cell.accessoryView = UISwitch()
            //
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
            
            let flagSwitch = UISwitch()
            flagSwitch.isOn = todo.flag
            flagSwitch.addTarget(self, action: #selector(flagSwitchChanged(_:)), for: .valueChanged)
            
            cell.accessoryView = flagSwitch
            cell.selectionStyle = .none
            
        } else if indexPath == IndexPath(row: 0, section: 4){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "priorityCell")
            cell.textLabel?.text = "우선순위"
            cell.accessoryType = .disclosureIndicator
            
            cell.detailTextLabel?.text = todo.priority?.priorityDescription
            
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
        if indexPath == IndexPath(row: 0, section: 0){
            let vc = AddDateViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath == IndexPath(row: 0, section: 1) {
            let vc = AddTagViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath == IndexPath(row: 0, section: 2) {
            // 위치 미개발 토스트 메시지
            self.view.makeToast("아직 구현 중입니다!", duration: 3.0, position: .bottom)
        } else if indexPath == IndexPath(row: 0, section: 4) {
            // 우선순위
            let vc = AddPriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath == IndexPath(row: 0, section: 5) {
            let vc =  AddImageViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
