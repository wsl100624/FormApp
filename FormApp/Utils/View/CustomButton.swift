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
        backgroundColor = .systemPink.withAlphaComponent(0.3)
        titleLabel?.font = .appButtonFont
        layer.cornerRadius = 12
        setEnable(false)
        
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.appOrangeColor.cgColor, UIColor.appPinkColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: -0.2, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 12
        return gradientLayer
    }()
    
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
    
    func setEnable(_ enable: Bool) {
        isEnabled = enable
        if enable {
            setTitleColor(.white, for: .normal)
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            setTitleColor(.secondarySystemFill, for: .normal)
            gradientLayer.removeFromSuperlayer()
        }
    }
}

