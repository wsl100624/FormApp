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
        animateTap()
        
        guard fieldsValidated() else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return
        }
        
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        submitButton.showLoading()

        // Checked email and password text, so we are good to use ! here.
        let profileInfo = Profile(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text, website: websiteTextField.text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.submitButton.hideLoading()
            self.navigationController?.pushViewController(ConfirmationVC(profileInfo), animated: true)
        }
    }
    
    private func animateTap() {
        UIButton.animate(withDuration: 0.1, animations: {
            self.submitButton.transform = .init(scaleX: 0.97, y: 0.97)
        }, completion: { _ in
            UIButton.animate(withDuration: 0.1, animations: {
                self.submitButton.transform = .identity
            })
        })
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
            if trimmed.count < .minEmailLength || !trimmed.isValidEmail() {
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
        
        if let text = websiteTextField.text {
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.count > .minUrlLength && !trimmed.isValidURL() {
                showAlert(.url) { _ in self.backToWebsiteTextField() }
                return false
            }
        }
        
        return true
    }
    
    private func backToEmailTextField() {
        emailTextField.text = nil
        emailTextField.becomeFirstResponder()
    }
    
    private func backToPasswordTextField() {
        passwordTextField.text = nil
        passwordTextField.becomeFirstResponder()
    }
    
    private func backToWebsiteTextField() {
        websiteTextField.text = nil
        websiteTextField.becomeFirstResponder()
    }
}


private extension Int {
    static let minEmailLength: Int = 5
    static let minPasswordLength: Int = 8
    static let minUrlLength: Int = 1
}
