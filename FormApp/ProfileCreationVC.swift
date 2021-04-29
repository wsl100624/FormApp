//
//  ProfileCreationVC.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

class ProfileCreationVC: FormVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        let testView = UIView(backgroundColor: .red)
//        view.addSubview(testView)
//        testView.centerInSuperview(size: .init(width: 100, height: 100))
        
        formStackView.addArrangedSubview(testView.setHeight(100))
    }
}
