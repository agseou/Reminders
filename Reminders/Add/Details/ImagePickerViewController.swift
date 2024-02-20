//
//  ImagePickerViewController.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/20.
//

import UIKit
import SnapKit

class ImagePickerViewController: BaseViewController {

    let photoImage = UIImageView()
    let addButton = UIButton()
    let repository = ReminderRepository()
    let data = ReminderModel()
    
    override func configureHierarchy() {
        view.addSubview(photoImage)
        view.addSubview(addButton)
    }
    
    override func configureView() {
        super.configureView()
        
        var config = UIButton.Configuration.filled()
        config.title = "사진 추가"
        addButton.configuration = config
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapCompleteButton))
        navigationItem.rightBarButtonItem = completeBarButtonItem
    }
    
    override func configureConstraints() {
        photoImage.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        addButton.snp.makeConstraints {
            $0.top.equalTo(photoImage.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(40)
        }
    }
    
    @objc func tapAddButton() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func tapCompleteButton() {
        if let image = photoImage.image {
            saveImageToDocument(image: image, filename: "\(data.id)")
        }
        repository.createItem(data)
        dismiss(animated: true)
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImage.image = pickedImage
        }
        
        dismiss(animated: true)
    }
}
