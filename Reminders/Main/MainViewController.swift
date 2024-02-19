//
//  MainViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {

    let searchController = UISearchController()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        
        // 목록 편집 버튼
        let editBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(tapEditButton))
        navigationItem.rightBarButtonItem = editBarButtonItem
        
        // 검색 바
        navigationItem.searchController = searchController
        
        // 새로운 미리 알림 버튼
        let addReminderButton = UIButton()
        var addReminderConfig = UIButton.Configuration.plain()
        addReminderConfig.title = "새로운 미리 알림"
        addReminderConfig.image = UIImage(systemName: "plus.circle.fill")
        addReminderButton.configuration = addReminderConfig
        addReminderButton.addTarget(self, action: #selector(tapAddRemiderButton), for: .touchUpInside)
        let addRemiderButtonItem = UIBarButtonItem(customView: addReminderButton)
        
        // 목록 추가 버튼
        let addListButton = UIButton()
        var addListConfig = UIButton.Configuration.plain()
        addListConfig.title = "목록 추가"
        addListButton.configuration = addListConfig
        addListButton.addTarget(self, action: #selector(tapAddListButton), for: .touchUpInside)
        let addListButtonItem = UIBarButtonItem(customView: addListButton)
        
        // toolbar 설정
        toolbarItems = [addRemiderButtonItem, UIBarButtonItem(systemItem: .flexibleSpace), addListButtonItem]
        
        navigationController?.setToolbarHidden(false, animated: false)
        
        // collectionView 설정
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // collectionView Layout 설정 함수
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/2 - 22.5
        layout.itemSize = CGSize(width: width, height: width/2)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 15, left: 15, bottom: 5, right: 15)
        return layout
    }
    
    // 새로운 미리 알림 버튼 액션
    @objc func tapAddRemiderButton() {
        let vc = UINavigationController(rootViewController: AddViewController())
        present(vc, animated: true)
    }
    
    // 목록 추가 버튼 액션
    @objc func tapAddListButton() {
        
    }
    
    // 목록 편집 버튼 액션
    @objc func tapEditButton() {
        
    }
    
}


// MARK: - CollectionView Extension
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        return cell
    }
    
    
}
