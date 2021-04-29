//
//  ConfirmationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit
import SwiftUI

class ConfirmationVC: UIViewController {
    
    private var profile: Profile
    
    lazy var titleLabel = CustomTitleLabel(text: Content.confirmation(profile.firstName).title)
    lazy var subtitleLabel = CustomSubtitleLabel(text: Content.confirmation().subtitle)
    lazy var webLabel = UnderlineLabel(text: profile.website)
    lazy var firstNameLabel = UILabel(text: profile.firstName, font: .appBodyFont, textAlignment: .center)
    lazy var emailLabel = UILabel(text: profile.email, font: .appBodyFont, textAlignment: .center)
    lazy var signInButton = CustomButton(title: "sign in")
    
    init(_ profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        setupSubViews()
    }
    
    private func setupSubViews() {
        setupMainStackView()
        setupProfileStackView()
        signInButton.setEnable(true)
    }
    
    private func setupMainStackView() {
        let subviews = [titleLabel,
                        subtitleLabel,
                        UIView(),
                        signInButton.setHeight(.buttonHeight)]
        
        let mainSV = UIStackView(arrangedSubviews: subviews)
        mainSV.axis = .vertical
        mainSV.setCustomSpacing(.spaceAfterTitle, after: titleLabel)
        mainSV.isLayoutMarginsRelativeArrangement = true
        mainSV.layoutMargins = .init(top: .zero, left: .padLeftRight, bottom: .zero, right: .padLeftRight)
        
        view.addSubview(mainSV)
        mainSV.fillSuperviewSafeAreaLayoutGuide()
    }
    
    private func setupProfileStackView() {
        let profileSV = UIStackView(arrangedSubviews: [webLabel, firstNameLabel, emailLabel])
        profileSV.axis = .vertical
        profileSV.spacing = .padLeftRight
        profileSV.distribution = .fillEqually
        view.addSubview(profileSV)
        profileSV.centerInSuperview()
        
        firstNameLabel.isHidden = firstNameLabel.text == nil || firstNameLabel.text == ""
        webLabel.isHidden = webLabel.text == nil || webLabel.text == ""
    }
}



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
