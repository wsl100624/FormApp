//
//  UIViewController+Ext.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, onOK: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: onOK)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
        }
    }
    
}


