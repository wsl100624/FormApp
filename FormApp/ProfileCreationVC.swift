//
//  ProfileCreationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

class ProfileCreationVC: FormVC {
    
    lazy var titleLabel = CustomTitleLabel(text: Content.profileCreation.title)
    lazy var subtitleLabel = CustomSubtitleLabel(text: Content.profileCreation.subtitle)
    
    lazy var firstNameTextField = CustomTextField(.firstname)
    lazy var emailTextField = CustomTextField(.email, target: self, action: #selector(handleTextChange))
    lazy var passwordTextField = CustomTextField(.password, target: self, action: #selector(handleTextChange))
    lazy var websiteTextField = CustomTextField(.website)
    lazy var spacer = UIView()
    lazy var submitButton = CustomButton(title: "submit", target: self, action: #selector(submitPressed))
    
    lazy var textFields: [UITextField] = {
        let tfs = [firstNameTextField, emailTextField, passwordTextField, websiteTextField]
        var tag = 0
        tfs.forEach { $0.tag = tag; tag += 1 }
        return tfs
    }()
    
    lazy var textFieldSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: textFields)
        sv.axis = .vertical
        sv.spacing = .padLeftRight
        sv.distribution = .fillEqually
        return sv
    }()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addTapGesture()
        addTextFieldDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        setupSubViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if distanceToBottom > .padBottom {
            spacer.setHeight(distanceToBottom - .padBottom)
        }
    }
    
    
    // MARK: - Subviews
    
    fileprivate func addTapGesture() {
        rootScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    fileprivate func addTextFieldDelegate() {
        textFields.forEach { $0.delegate = self }
    }
    
    private func setupSubViews() {
        let subviews = [titleLabel,
                        subtitleLabel,
                        textFieldSV.setHeight(.textFieldContainerHeight),
                        spacer,
                        submitButton.setHeight(.buttonHeight)
        ]
        
        subviews.forEach { formStackView.addArrangedSubview($0) }
        
        formStackView.layoutMargins = .init(top: .zero, left: .padLeftRight, bottom: .zero, right: .padLeftRight)
        formStackView.setCustomSpacing(.spaceAfterTitle, after: titleLabel)
        formStackView.setCustomSpacing(.spaceAfterSubtitle, after: subtitleLabel)
    }
    
    
    // MARK: - Actions
    
    @objc func submitPressed() {
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
    
    
    // MARK: - TextField Functions
    
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
            if trimmed.count < .minEmailLength {
                showAlert(.email) { _ in self.backToEmailTextField() }
                return false
            }
        }
        
        if let text = passwordTextField.text {
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.count < .minPasswordLength {
                showAlert(.password) { _ in self.backToPasswordTextField() }
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
}


private extension Int {
    static let minEmailLength: Int = 5
    static let minPasswordLength: Int = 8
}
