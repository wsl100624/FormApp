//
//  ProfileCreation+UITextField.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit


extension ProfileCreationVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .next && textField.tag != textFields.count - 1 {
            let nextTag = textField.tag + 1
            textFields[nextTag].becomeFirstResponder()
        } else {
            view.endEditing(true)
            submitPressed()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? CustomTextField {
            textField.coloring()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? CustomTextField {
            textField.restoreColor()
        }
    }
}
