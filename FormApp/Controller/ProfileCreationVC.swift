//
//  ProfileCreationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit



// Decision: - I used a self-created "form" controller to rendering this screen.
// Benefit:
// 1. It come with a root scroll view to give user a vertical bouncing experience.
// 2. The root scroll view can let user dismiss the keyboard by dragging down from anywhere.
// 3. The root scroll view can extend content size to fit unlimited views, so user can scroll to the bottom even when the keyboard is on the screen
// 4. It come with a root stack view, so we can just add views in there and config the stack view's spacing and margin, and etc... so that we don't need to worry about auto layout.


class ProfileCreationVC: FormVC {
    
    lazy var titleLabel = CustomTitleLabel(text: Content.profileCreation.title)
    lazy var subtitleLabel = CustomSubtitleLabel(text: Content.profileCreation.subtitle)
    lazy var firstNameTextField = CustomTextField(.firstname)
    lazy var emailTextField = CustomTextField(.email, target: self, action: #selector(handleTextChange))
    lazy var passwordTextField = CustomTextField(.password, target: self, action: #selector(handleTextChange))
    lazy var websiteTextField = CustomTextField(.website)
    lazy var spacer = UIView()
    lazy var submitButton = CustomButton(title: "submit", target: self, action: #selector(submitPressed))
    
    
    // Decision: - assign tags to each textField.
    // Benefit: - its easy to choose later in delegate method.
    lazy var textFields: [UITextField] = {
        let tfs = [firstNameTextField, emailTextField, passwordTextField, websiteTextField]
        var tag = 0
        tfs.forEach { $0.tag = tag; tag += 1 }
        return tfs
    }()
    
    
    // Decision: - made a stack view for all textField
    // Benefit: - easy to manage spacing and size, as later this will put in the main stack view
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
        
        // Decision: - add scale button animation here when pressing button
        // Benefit: - it's important to let the user know, you actually clicked it.
        animateTap()
        
        guard fieldsValidated() else {
            // Decision: - add warning haptic feedback here
            // Benefit: - same benefit as above
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return
        }
        // Decision: - add success haptic feedback here
        // Benefit: - same benefit as above
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        // Decision: - add loading indicator animation inside the button
        // Benefit: - usually it'll involve some network request, so it tells the user to wait until it stop
        submitButton.showLoading()

        // Decision: - We checked email and password text, so we are good to use ! here.
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
    
    // Decision: - check email and password text field whenever user typed something
    // Benefit: - we can enable/disable the submit button, so user know they haven't finish the form yet
    @objc fileprivate func handleTextChange() {
        let isTextValid: Bool =
            emailTextField.text?.count ?? 0 != 0 &&
            passwordTextField.text?.count ?? 0 != 0
        
        submitButton.setEnable(isTextValid)
    }
    
    
    // Decision: - check if text valid, with white space trimmed string
    // Benefit: - user might accidently entered space at the begining/end of the texts, but the text might be valid if we trim it. Otherwise, they might have to enter it again.
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
    
    // Decision: - automatically bring user back to the problem textField.
    // Benefit: - they don't have to find it and tap it again.
    
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

// Decision: - make static but private constants
// Benefit: - it's private in this class, so it can only use in here. It's handy and able to separate hardcoded numbers from controller

private extension Int {
    static let minEmailLength: Int = 5
    static let minPasswordLength: Int = 8
    static let minUrlLength: Int = 1
}
