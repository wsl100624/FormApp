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
    lazy var signInButton = CustomButton(title: "sign in", target: self, action: #selector(signInPressed))
    
    // MARK: - Init
    
    // Decision: - Inject profile model
    // Benefit: - to make sure this screen can be presented with valid data
    init(_ profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        setupSubViews()
    }
    
    // MARK: - Subviews
    
    private func setupSubViews() {
        setupMainStackView()
        setupProfileStackView()
        signInButton.setEnable(true)
    }
    
    // Decision: - Use stack view to rendering the subviews
    // Benefit: - it's easy to use, able to cut off a bunch of auto layout code, and easy to maintain.
    private func setupMainStackView() {
        
        
        // Decision: - Add a spacer-like UIView here
        // Benefit: - it can expand and fill the blank space, so that the subviews can snap on the tap/bottom.
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
        
        // Decision: - hide empty labels
        // Benefit: - because they're in stackview, hiding it will shrink the stackview, so it can still at the center of the screen.
        firstNameLabel.isHidden = firstNameLabel.text == nil || firstNameLabel.text == ""
        webLabel.isHidden = webLabel.text == nil || webLabel.text == ""
    }
    
    // MARK: - Actions
    
    @objc private func signInPressed() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        animateTap()
    }
    
    private func animateTap() {
        UIButton.animate(withDuration: 0.1, animations: {
            self.signInButton.transform = .init(scaleX: 0.97, y: 0.97)
        }, completion: { _ in
            UIButton.animate(withDuration: 0.1, animations: {
                self.signInButton.transform = .identity
            })
        })
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
