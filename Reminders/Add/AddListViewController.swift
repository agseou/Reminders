//
//  AddListViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit

class AddListViewController: BaseViewController {
    
    // [미해결] 네비게이션바에 타이틀 아래에 segmentControl 넣기
    // -> Naviagationbar 자체 높이 조절은 애플에서 지원하지 않음
    
    let navigationStackView = UIStackView()
    let segmentedControl = UISegmentedControl(items: ["새로운 목록", "템플릿"])
    let newListTableView = UITableView()
    let templateTableView = UITableView()
    
    
    override func configureHierarchy() {
        view.addSubview(newListTableView)
        view.addSubview(templateTableView)
    }
    
    override func configureView() {
        super.configureView()
        newListTableView.isHidden = false
        navigationItem.title = "새로운 목록"
        
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(tapCancelButton))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let addBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(tapAddButton))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        navigationItem.titleView = segmentedControl
        newListTableView.delegate = self
        newListTableView.dataSource = self
        newListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func configureConstraints() {
        newListTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        templateTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func tapCancelButton() {
        checkCancelActionSheet() {
            self.dismiss(animated: true)
        }
    }
    
    @objc func tapAddButton() {
        dismiss(animated: true)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        newListTableView.isHidden = sender.selectedSegmentIndex != 0
        templateTableView.isHidden = sender.selectedSegmentIndex != 1
    }
}

extension AddListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "star")
        content.text = "미리 알림"
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
