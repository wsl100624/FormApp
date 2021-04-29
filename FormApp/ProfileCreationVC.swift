//
//  ProfileCreationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

private extension CGFloat {
    static let spaceAfterTitle: CGFloat = 4
    static let padLeftRight: CGFloat = 18
    static let padBottom: CGFloat = 32
    static let buttonHeight :CGFloat = 60
    static let textFieldContainerHeight: CGFloat = 4 * buttonHeight + 3 * padLeftRight
}

class ProfileCreationVC: FormVC {
    
    lazy var titleLabel = UILabel(text: "Profile Creation".capitalized, font: .systemFont(ofSize: 32, weight: .heavy), textColor: .label)
    lazy var subtitleLabel = UILabel(text: "Use the form below to submit your portfolio. An email and password are required.".capitalized, font: .systemFont(ofSize: 15, weight: .semibold), textColor: .secondaryLabel, numberOfLines: 0)
    
    lazy var firstNameTextField: CustomTextField = {
        let tf = CustomTextField(.firstname)
        tf.autocapitalizationType = .words
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField(.email)
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    
    lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField(.password)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var websiteTextField: CustomTextField = {
        let tf = CustomTextField(.website)
        tf.keyboardType = .URL
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var textFields: [UITextField] = {
        let tfs = [firstNameTextField, emailTextField, passwordTextField, websiteTextField]
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
    
    lazy var submitButton = CustomButton(title: "submit")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        
//        print(#function)
        
        var isFormValid: Bool = true
        textFields.forEach { isFormValid = $0.text?.count ?? 0 != 0 }
        
//        signUpButton.isEnabled = isFormValid
//        signUpButton.backgroundColor = isFormValid ? appYellow : .systemFill
    }
    
    
}
