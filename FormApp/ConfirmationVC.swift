//
//  ConfirmationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

class ConfirmationVC: UIViewController {
    
    private var profile: Profile
    
    init(_ profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel = CustomTitleLabel(text: "Hello, \(profile.firstName ?? "")")
    lazy var subtitleLabel = CustomSubtitleLabel(text: "Your super-awesome portfolio has been successfully submitted! The details below will be public within your community!")
    
    lazy var webLabel = UnderlineLabel(text: profile.website ?? "")
    lazy var firstNameLabel = UILabel(text: profile.firstName ?? "", font: .appBodyFont, textAlignment: .center)
    lazy var emailLabel = UILabel(text: profile.email, font: .appBodyFont, textAlignment: .center)
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
