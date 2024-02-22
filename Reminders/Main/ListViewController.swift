//
//  ListViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit
import RealmSwift

class ListViewController: BaseViewController {

    let tableView = UITableView()
    let viewTitle: String = "전체"
    let repository = ReminderRepository()
    var list : Results<ReminderModel>!
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        list = repository.fetchItem(ofType: ReminderModel.self)
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = viewTitle
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
    }

    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        let row = list[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.memoLabel.text = row.memo
        cell.dateLabel.text = row.date?.formattedDate
        
        return cell
    }
    
    
}
