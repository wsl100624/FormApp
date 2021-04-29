//
//  UIView+Ext.swift
//  
//
//  Created by Will Wang on 3/20/20.
//

import UIKit

public struct ViewConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

@available(iOS 11.0, tvOS 11.0, *)
public enum Anchor {
    case top(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case leading(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case trailing(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case height(_ constant: CGFloat)
    case width(_ constant: CGFloat)
}


@available(iOS 11.0, tvOS 11.0, *)
extension UIView {
    
    @discardableResult
    open func anchor(_ anchors: Anchor...) -> ViewConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var viewConstraints = ViewConstraints()
        anchors.forEach { anchor in
            switch anchor {
            case .top(let anchor, let constant):
                viewConstraints.top = topAnchor.constraint(equalTo: anchor, constant: constant)
            case .leading(let anchor, let constant):
                viewConstraints.leading = leadingAnchor.constraint(equalTo: anchor, constant: constant)
            case .bottom(let anchor, let constant):
                viewConstraints.bottom = bottomAnchor.constraint(equalTo: anchor, constant: -constant)
            case .trailing(let anchor, let constant):
                viewConstraints.trailing = trailingAnchor.constraint(equalTo: anchor, constant: -constant)
            case .height(let constant):
                if constant > 0 {
                    viewConstraints.height = heightAnchor.constraint(equalToConstant: constant)
                }
            case .width(let constant):
                if constant > 0 {
                    viewConstraints.width = widthAnchor.constraint(equalToConstant: constant)
                }
            }
        }
        [viewConstraints.top,
         viewConstraints.leading,
         viewConstraints.bottom,
         viewConstraints.trailing,
         viewConstraints.width,
         viewConstraints.height].forEach {
            $0?.isActive = true
        }
        return viewConstraints
    }
    
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> ViewConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var viewConstraints = ViewConstraints()
        
        if let top = top {
            viewConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            viewConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            viewConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            viewConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            viewConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            viewConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [viewConstraints.top, viewConstraints.leading, viewConstraints.bottom, viewConstraints.trailing, viewConstraints.width, viewConstraints.height].forEach{ $0?.isActive = true }
        
        return viewConstraints
    }
    
    @discardableResult
    open func fillSuperview(padding: UIEdgeInsets = .zero) -> ViewConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let viewConstraints = ViewConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return viewConstraints
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    open func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> ViewConstraints {
        let viewConstraints = ViewConstraints()
        guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
            let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
            let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
            let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                return viewConstraints
        }
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    open func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXTo(_ anchor: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    open func centerYTo(_ anchor: NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    open func centerXToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    open func centerYToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }
    
    @discardableResult
    open func setSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }
    
    @discardableResult
    open func setHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func setWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    convenience public init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
}

