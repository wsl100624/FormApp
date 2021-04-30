//
//  FormVC.swift
//  
//
//  Created by Will Wang on 3/18/20.
//

import UIKit

#if os(iOS)
@available(iOS 11.0, *)
open class FormVC: UIViewController {
    
    // MARK: - Property
    
    public lazy var rootScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.contentSize = view.frame.size
        sv.keyboardDismissMode = .interactive
        sv.alwaysBounceVertical = true
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    public let formStackView: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.axis = .vertical
        return sv
    }()
    
    var lastItem: UIView!
    
    lazy var distanceToBottom = distanceFromLastItemToBottom()
    
    // MARK: - Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("FormVC is failed to init.")
    }
    
    // MARK: - View Controller Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupRootScrollView()
        setupFormStackView()
        setupKeyboardNotifications()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        extendContentSizeIfNeeded()
        _ = distanceToBottom
    }
    
    // MARK: - Subviews
    
    fileprivate func setupRootScrollView() {
        view.addSubview(rootScrollView)
        rootScrollView.fillSuperview()
        rootScrollView.addSubview(formStackView)
        rootScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    fileprivate func setupFormStackView() {
        formStackView.anchor(top: rootScrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    }
    
    fileprivate func extendContentSizeIfNeeded() {
        if formStackView.frame.height > view.frame.height {
            rootScrollView.contentSize.height = formStackView.frame.size.height
        }
    }
    
    fileprivate func distanceFromLastItemToBottom() -> CGFloat {
        if lastItem != nil {
            guard let frame = lastItem.superview?.convert(lastItem.frame, to: view) else { return 0 }
            let distance = view.frame.height - frame.origin.y - frame.height
            return distance
        } else {
            return view.frame.height - formStackView.frame.maxY
        }
    }
    
    
    // MARK: - Keyboard Management
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    
    fileprivate func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        rootScrollView.contentInset.bottom = keyboardFrame.height
        
        if distanceToBottom > 0 {
            rootScrollView.contentInset.bottom -= distanceToBottom
        }
    }
    
    @objc fileprivate func handleKeyboardHide() {
        rootScrollView.contentInset.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
#endif

