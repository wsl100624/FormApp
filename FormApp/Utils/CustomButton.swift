//
//  CustomButton.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit


class CustomButton: UIButton {
    
    var indicatorColor: UIColor = .white
    var indicatorStyle: UIActivityIndicatorView.Style = .medium
    private var originalTitleColor: UIColor = .white
    
    convenience init(title: String, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        
        setTitle(title.capitalized, for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.secondaryLabel, for: .disabled)
        backgroundColor = .red
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        layer.cornerRadius = 12
        
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: indicatorStyle)
        indicator.color = indicatorColor
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func showLoading() {
        originalTitleColor = self.currentTitleColor
        setTitleColor(UIColor.clear, for: .normal)
        
        self.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.setTitleColor(self.originalTitleColor, for: .normal)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}

