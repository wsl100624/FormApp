//
//  ConfirmationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

private extension CGFloat {
    static let spaceAfterTitle: CGFloat = 8
    static let padLeftRight: CGFloat = 18
    static let padBottom: CGFloat = 32
    static let buttonHeight :CGFloat = 60
    static let textFieldContainerHeight: CGFloat = 4 * buttonHeight + 3 * padLeftRight
}

class ConfirmationVC: UIViewController {
    
    private var profile: Profile
    
    init(_ profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel = UILabel(text: "Hello, \(profile.firstName ?? "")", font: .systemFont(ofSize: 34, weight: .heavy), textColor: .label)
    lazy var subtitleLabel = UILabel(text: "Your super-awesome portfolio has been successfully submitted! The details below will be public within your community!", font: .systemFont(ofSize: 15, weight: .semibold), textColor: .secondaryLabel, numberOfLines: 0)
    
    lazy var webLabel = UILabel(text: profile.website ?? "", textAlignment: .center)
    lazy var firstNameLabel = UILabel(text: profile.firstName ?? "", font: .boldSystemFont(ofSize: 16), textColor: .label, textAlignment: .center)
    lazy var emailLabel = UILabel(text: profile.email, font: .boldSystemFont(ofSize: 16), textColor: .label, textAlignment: .center)
    lazy var signInButton = CustomButton(title: "sign in", target: self, action: #selector(signInTapped))
    
    @objc func signInTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    var spacer = UIView()
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        
        let profileStackView = UIStackView(arrangedSubviews: [webLabel, firstNameLabel, emailLabel])
        profileStackView.axis = .vertical
        profileStackView.spacing = .padLeftRight
        profileStackView.distribution = .fillEqually
        
        let subviews = [titleLabel,
                        subtitleLabel,
                        spacer,
                        signInButton.setHeight(.buttonHeight)
        ]
        
        stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.setCustomSpacing(.spaceAfterTitle, after: titleLabel)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: .zero, left: .padLeftRight, bottom: .zero, right: .padLeftRight)
        
        view.addSubview(stackView)
        stackView.fillSuperviewSafeAreaLayoutGuide()
        
        view.addSubview(profileStackView)
        profileStackView.centerInSuperview()
        
        signInButton.setEnable(true)
        
    }
    
}

import SwiftUI

struct ConfirmationVCPreview: PreviewProvider {
    
    static var previews: some View {
        Container().ignoresSafeArea()
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<ConfirmationVCPreview.Container>) -> UIViewController {
            let profile = Profile(email: "will@test.com", password: "sdfsdfsdfdsf", firstName: "Will", website: "sfsdfsdf.com")
            return ConfirmationVC(profile)
        }
        
        func updateUIViewController(_ uiViewController: ConfirmationVCPreview.Container.UIViewControllerType, context: UIViewControllerRepresentableContext<ConfirmationVCPreview.Container>) {}
    }
    
}
