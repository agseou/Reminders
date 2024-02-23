//
//  AddImageViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/23.
//

import UIKit
import SnapKit

class AddImageViewController: BaseViewController {
    
    let photoImageView = UIImageView()
    let addImageButon = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(photoImageView)
        view.addSubview(addImageButon)
    }
    
    override func configureView() {
        super.configureView()
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(tapCancelButton))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapCompleteButton))
        navigationItem.rightBarButtonItem = completeBarButtonItem
        
        var config = UIButton.Configuration.filled()
        config.title = "이미지 추가하기"
        addImageButon.configuration = config
        addImageButon.addTarget(self, action: #selector(tapAddImageButton), for: .touchUpInside)
    }
    
    override func configureConstraints() {
        photoImageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(200)
        }
        addImageButon.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.top.equalTo(photoImageView.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
    }
    
    @objc func tapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapCompleteButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapAddImageButton() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImageView.image = pickedImage
        }
        
        dismiss(animated: true)
    }
    
}

