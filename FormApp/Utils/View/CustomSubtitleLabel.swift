//
//  CustomSubtitleLabel.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

// Decision: - make custom title label
// Benefit: - so it can be used throughout the project. we can also remove boiler code from controllers.

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

// Decision: - Use system provided label color
// Benefit: - support dark mode, which is a must have feature as only 8% devices not updated to ios 13+ yet

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


