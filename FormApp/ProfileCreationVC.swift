//
//  ProfileCreationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit


class ProfileCreationVC: FormVC {
    
    lazy var titleLabel = CustomTitleLabel(text: "Profile Creation".capitalized)
    lazy var subtitleLabel = CustomSubtitleLabel(text: "Use the form below to submit your portfolio. An email and password are required.")
    
    lazy var firstNameTextField = CustomTextField(.firstname)
    lazy var emailTextField = CustomTextField(.email, target: self, action: #selector(handleTextChange))
    lazy var passwordTextField = CustomTextField(.password, target: self, action: #selector(handleTextChange))
    lazy var websiteTextField = CustomTextField(.website)
    
    lazy var textFields: [UITextField] = {
        let tfs = [firstNameTextField, emailTextField, passwordTextField, websiteTextField]
        var tag = 0
        tfs.forEach { $0.tag = tag; tag += 1 }
        return tfs
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: textFields)
        sv.axis = .vertical
        sv.spacing = .padLeftRight
        sv.distribution = .fillEqually
        return sv
    }()
    
    var spacer = UIView()
    
    lazy var submitButton = CustomButton(title: "submit", target: self, action: #selector(submitPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        rootScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        
        textFields.forEach { $0.delegate = self }
        
        #if DEBUG
        firstNameTextField.text = "Will"
        emailTextField.text = "will@test.com"
        passwordTextField.text = "123123123123"
        websiteTextField.text = "will.wang.com"
        submitButton.setEnable(true)
        #endif
    }
    
    override func viewDidLayoutSubviews() {
        
        let subviews = [titleLabel,
                        subtitleLabel,
                        textFieldStackView.setHeight(.textFieldContainerHeight),
                        spacer,
                        submitButton.setHeight(.buttonHeight)
        ]
        
        subviews.forEach { formStackView.addArrangedSubview($0) }
        
        formStackView.layoutMargins = .init(top: .zero, left: .padLeftRight, bottom: .zero, right: .padLeftRight)
        formStackView.setCustomSpacing(.spaceAfterTitle, after: titleLabel)
        formStackView.setCustomSpacing(.padBottom * 2, after: subtitleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if distanceToBottom > .padBottom {
            spacer.setHeight(distanceToBottom - .padBottom)
        }
    }
    
    @objc fileprivate func handleTextChange() {
        let isTextValid: Bool =
            emailTextField.text?.count ?? 0 != 0 &&
            passwordTextField.text?.count ?? 0 != 0
        
        submitButton.setEnable(isTextValid)
    }
    
    func fieldsValidated () -> Bool {
        
        if let text = emailTextField.text {
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            // a@b.c
            if trimmed.count < 5 {
                let okAction: ((UIAlertAction) -> Void) = { _ in self.backToEmailTextField() }
                showAlert(title: "Invalid Email", message: "You entered an invalid email, please try again.", onOK: okAction)
                return false
            }
        }
        
        if let text = passwordTextField.text {
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.count < 8 {
                let okAction: ((UIAlertAction) -> Void) = { _ in self.backToPasswordTextField() }
                showAlert(title: "Password is too short", message: "Password should be at least 8 characters, please try again.", onOK: okAction)
                return false
            }
        }
        
        return true
    }
    
    private func backToEmailTextField() {
        emailTextField.becomeFirstResponder()
    }
    
    private func backToPasswordTextField() {
        passwordTextField.becomeFirstResponder()
    }
    
    @objc fileprivate func submitPressed() {
        print(#function)
        guard fieldsValidated() else { return }
        submitButton.showLoading()
        
        // Checked email and password text, so we are good to use ! here.
        let profileInfo = Profile(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text, website: websiteTextField.text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.submitButton.hideLoading()
            self.navigationController?.pushViewController(ConfirmationVC(profileInfo), animated: true)
        }
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
}


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
