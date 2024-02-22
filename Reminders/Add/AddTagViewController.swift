//
//  addTagViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit
import RealmSwift

class AddTagViewController: BaseViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let textField = UITextField()
    var tempList: [String?] = []
    var tagList: List<String?> = List<String?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tagListCell")
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
        return tempList.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !tempList.isEmpty {
            if indexPath.section == 0 {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "tagListCell")
                
                cell.textLabel?.text = tempList[0]
                
                return cell
            } else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "insertTagCell")
                
                cell.contentView.addSubview(textField)
                textField.placeholder = "새로운 태그 추가..."
                textField.snp.makeConstraints {
                    $0.edges.equalTo(cell.contentView)
                    $0.height.equalTo(40)
                }
                
                return cell
            }
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "insertTagCell")
            
            cell.contentView.addSubview(textField)
            textField.placeholder = "새로운 태그 추가..."
            textField.snp.makeConstraints {
                $0.edges.equalTo(cell.contentView)
                $0.height.equalTo(40)
            }
            
            return cell
        }
    }
}

extension AddTagViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("tap")
        guard let newTag = textField.text, !newTag.isEmpty else { return }
        print(newTag)
        tempList.append(newTag)
        print(tempList)
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
