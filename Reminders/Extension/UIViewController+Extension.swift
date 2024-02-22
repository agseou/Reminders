//
//  UIViewController+Extension.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/22.
//

import UIKit

extension UIViewController {
    func checkCancelActionSheet(completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "변경사항 폐기", style: .destructive) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
