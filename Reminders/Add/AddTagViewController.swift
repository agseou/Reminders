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
    let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let textField = UITextField()
    let repository = ReminderRepository()
    var tagList: Results<TagModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagList = repository.fetchItem(ofType: TagModel.self)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(tapCancelButton))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapCompleteButton))
        navigationItem.rightBarButtonItem = completeBarButtonItem
        
        
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tagListCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "insertTagCell")
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    @objc func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func tapCompleteButton() {
        dismiss(animated: true)
    }
}


extension AddTagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tagList.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !tagList.isEmpty {
            if indexPath.section == 0 {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "tagListCell")
                cell.contentView.addSubview(tagCollectionView)
                tagCollectionView.snp.makeConstraints {
                    $0.edges.equalTo(cell.contentView)
                    $0.height.greaterThanOrEqualTo(40)
                }
                
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

extension AddTagViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        
        cell.tagButton.configuration?.title = tagList[indexPath.item].tag
        
        return cell
    }
    
}

extension AddTagViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("tap")
        guard let newTag = textField.text, !newTag.isEmpty else { return }
        if (tagList.first(where: { $0.tag == newTag }) != nil) { return }
        repository.createItem(TagModel(tag: newTag))
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = nil
        tagCollectionView.reloadData()
        return true
    }
}
