//
//  UIViewController+Ext.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ type: Alert, onOK: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: onOK)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
        }
    }
    
}


