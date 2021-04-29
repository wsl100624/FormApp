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
        
        font = .boldSystemFont(ofSize: 16)
        textColor = .label
        autocapitalizationType = .none
        autocorrectionType = .no
        borderStyle = .none
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondarySystemFill.cgColor
        layer.cornerRadius = 12
        
        attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.foregroundColor : UIColor.secondaryLabel, .font : UIFont.boldSystemFont(ofSize: 16)])
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: .padding, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: .padding, dy: 0)
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

private extension CGFloat {
    static let padding: CGFloat = 18
}
