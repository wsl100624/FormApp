//
//  CustomSubtitleLabel.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

class CustomTitleLabel: UILabel {
    
    convenience init(text: String?) {
        self.init(frame: .zero)
        self.text = text
        self.font = .appTitleFont
        self.adjustsFontForContentSizeCategory = true
        self.textColor = .label
        self.numberOfLines = 0
    }
}

class CustomSubtitleLabel: UILabel {
    
    convenience init(text: String?) {
        self.init(frame: .zero)
        self.text = text
        self.font = .appSubtitleFont
        self.adjustsFontForContentSizeCategory = true
        self.textColor = .secondaryLabel
        self.numberOfLines = 0
    }
}


