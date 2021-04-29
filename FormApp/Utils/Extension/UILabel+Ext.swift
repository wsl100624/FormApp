//
//  UILabel+Ext.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, font: UIFont? = UIFont.appTitleFont, textColor: UIColor = .label, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 0) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.adjustsFontForContentSizeCategory = true
    }
}
