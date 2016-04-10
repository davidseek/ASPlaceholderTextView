//
//  ASPlaceholderTextView.swift
//  Pods
//
//  Created by Adam J Share on 4/9/16.
//
//

import UIKit

// @IBDesignable
public class ASPlaceholderTextView: UITextView {
    
    @IBInspectable public var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
            placeholderLabel.sizeToFit()
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            placeholderLabel.textColor = placeholderColor;
        }
    }
    
    private var secondaryDelegate: UITextViewDelegate?
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupLabel(placeholderLabel)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel(placeholderLabel)
    }
    
    var left: NSLayoutConstraint?
    var width: NSLayoutConstraint?
    var top: NSLayoutConstraint?
    
    // @IBDesignable handle
    #if !TARGET_INTERFACE_BUILDER
    
    public var placeholderLabel: UILabel = UILabel()
    
    #else
    var _placeholderLabel: UILabel!
    var placeholderLabel: UILabel {
    get {
    if _placeholderLabel != nil {
    return _placeholderLabel
    }
    _placeholderLabel = UILabel()
    setupLabel(_placeholderLabel)
    }
    }
    #endif
    
    // For shared setup in interface builder @IBDesignable
    func setupLabel(placeholderLabel: UILabel) {
        
        placeholderLabel.userInteractionEnabled = false
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.text = placeholder;
        placeholderLabel.backgroundColor = UIColor.clearColor()
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.font = self.font;
        
        refreshLabelHidden()
        
        self.addSubview(placeholderLabel)
        
        let offset = self.textContainer.lineFragmentPadding;
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        left = NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1,
            constant: self.textContainerInset.left + offset
        )
        
        width = NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Width,
            multiplier: 1,
            constant: -(self.textContainerInset.right + offset + self.textContainerInset.left + offset)
        )
        
        top = NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1,
            constant: self.textContainerInset.top
        )
        
        self.addConstraints([left!, width!, top!])
    }
    
    func updateLabelConstraints() {
        
        let offset = self.textContainer.lineFragmentPadding;
        
        left?.constant = self.textContainerInset.left + offset
        width?.constant = -(self.textContainerInset.right + offset + self.textContainerInset.left + offset)
        top?.constant = self.textContainerInset.top
        
        self.setNeedsLayout()
    }
    
    func refreshLabelHidden() {
        if text == "" || text == nil {
            placeholderLabel.hidden = false;
            return
        } else {
            placeholderLabel.hidden = true;
        }
    }
}

// MARK: Forwarding Delegate
public extension ASPlaceholderTextView {
    
    override var delegate: UITextViewDelegate? {
        set {
            secondaryDelegate = newValue
        }
        get {
            return self
        }
    }
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        return super.respondsToSelector(aSelector) || secondaryDelegate?.respondsToSelector(aSelector) == true
    }
    
    override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
        
        if (secondaryDelegate?.respondsToSelector(aSelector) == true) {
            return secondaryDelegate
        }
        
        return super.forwardingTargetForSelector(aSelector)
    }
}


// MARK: Override text setters
public extension ASPlaceholderTextView {
    
    public override var font: UIFont? {
        didSet{
            placeholderLabel.font = font;
            placeholderLabel.sizeToFit()
        }
    }
    
    public override var textContainerInset: UIEdgeInsets {
        didSet {
            updateLabelConstraints()
        }
    }
    
    public override var text: String! {
        didSet {
            refreshLabelHidden()
            
            self.textViewDidChange(self)
        }
    }
    
    public override var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
}

// MARK: UITextView Delegate
extension ASPlaceholderTextView: UITextViewDelegate {
    
    public func textViewDidChange(textView: UITextView) {
        
        refreshLabelHidden()
        
        secondaryDelegate?.textViewDidChange?(textView)
    }
}

