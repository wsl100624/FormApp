//
//  UnderlineLabel.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

class UnderlineLabel: UILabel {
    
    convenience init(text: String?) {
        self.init(frame: .zero)
        self.text = text
    }
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedString.Key : Any] = [
                .underlineStyle:NSUnderlineStyle.single.rawValue,
                .foregroundColor : UIColor.appBlueColor,
                .paragraphStyle : paragraphStyle,
                .font : UIFont.appBodyFont
            ]
            let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
            self.attributedText = attributedText
        }
    }
}
