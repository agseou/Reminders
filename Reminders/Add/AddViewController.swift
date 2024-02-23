//
//  AddViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit
import RealmSwift

class AddViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let titleTextField = UITextField()
    let memoTextField = UITextView()
    let repository = ReminderRepository()
    var data = ReminderModel()
    
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
        navigationItem.rightBarButtonItem!.isEnabled = false
        
        titleTextField.delegate = self
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddView"), object: nil, userInfo: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveData), name: NSNotification.Name("Data"), object: nil)
    }
    
    @objc func receiveData(_ notification: NSNotification) {
        if let data = notification.userInfo?["Data"] as? ReminderModel {
            self.data.date = data.date
            self.data.flag = data.flag
            self.data.priority = data.priority
        }
    }
    
    @objc func tapCancelButton() {
        checkCancelActionSheet() {
            self.dismiss(animated: true)
        }
    }
    
    @objc func tapAddButton() {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        data.title = title
        data.memo = memoTextField.text
        
        repository.createItem(data)
        print(data)
        
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
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.verticalEdges.equalToSuperview()
                $0.height.equalTo(40)
            }
            
            cell.selectionStyle = .none
            
        } else if indexPath == IndexPath(row: 1, section: 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.contentView.addSubview(memoTextField)
            memoTextField.font = .systemFont(ofSize: 15)
            memoTextField.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.height.equalTo(120)
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
            vc.sender = {
                self.data.date = $0.date
                self.data.flag = $0.flag
                self.data.priority = $0.priority
            }
            vc.todo = data
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension AddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = titleTextField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        navigationItem.rightBarButtonItem!.isEnabled = !updatedText.isEmpty
        
        return true
    }
}
