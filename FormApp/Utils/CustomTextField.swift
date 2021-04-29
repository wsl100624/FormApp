//
//  CustomTextField.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit


class CustomTextField: UITextField {
    let placeholderString: String
    
    init(_ type: TextField) {
        placeholderString = type.rawValue.capitalized
        super.init(frame: .zero)
        
        font = .appBodyFont
        adjustsFontSizeToFitWidth = true
        textColor = .label
        autocapitalizationType = .none
        autocorrectionType = .no
        borderStyle = .none
        layer.borderWidth = .border
        layer.borderColor = .normalBorderColor
        layer.cornerRadius = .cornorRadius
        
        attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.foregroundColor : UIColor.placeholderColor, .font : UIFont.appBodyFont])
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: .padding, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: .padding, dy: 0)
    }
    
    func coloring() {
        layer.borderColor = .editingBorderColor
        attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.foregroundColor : UIColor.editingPlaceholderColor])
    }
    
    func restoreColor() {
        layer.borderColor = .normalBorderColor
        attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.foregroundColor : UIColor.placeholderColor])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum TextField: String {
    case firstname = "first name"
    case email = "email address"
    case password
    case website
}

private extension CGColor {
    static let normalBorderColor = UIColor.secondarySystemFill.cgColor
    static let editingBorderColor = UIColor.appPinkColor.cgColor
}

private extension UIColor {
    static let placeholderColor = UIColor.secondaryLabel
    static let editingPlaceholderColor = UIColor.appPinkColor
}

private extension CGFloat {
    static let cornorRadius: CGFloat = 12
    static let padding: CGFloat = 18
    static let border: CGFloat = 2
}
