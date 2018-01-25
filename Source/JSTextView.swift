//
//  UITextViewPlaceholder.swift
//  DoctorOnline
//
//  Created by 王俊硕 on 2018/1/4.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit


class JSTextView: UITextView, UITextViewDelegate {
    typealias OptionalEmptyClosure = (()->())?

    private var placeholderLabel: UILabel!
    var textDidChangedHandler: ((String)->())?
    var textDidClearedHandler: OptionalEmptyClosure
    var inputerWillBeginEditing: OptionalEmptyClosure
    var inputerWillEndEditing: OptionalEmptyClosure
    
    var jsPlaceholder: String = "请输入文字" {
        didSet {
            placeholderLabel.text = jsPlaceholder
        }
    }
    var hideKeyboardWhenTapReturn = true
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        placeholderLabel = UILabel(frame: CGRect(x: 12.5, y: 12.5, width: 374-25, height: 15).flWithMask())
        placeholderLabel.font = UIFont.systemFont(ofSize: 13)
        placeholderLabel.textColor = UIColor.from(hex: 0xaaaaaa)
        placeholderLabel.text = jsPlaceholder
        
        delegate = self
        textColor = UIColor.b333333
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: fl(15))
        textContainerInset = UIEdgeInsets(top: fl(12), left: fl(9), bottom: fl(9), right: fl(9))
        addSubview(placeholderLabel)
        returnKeyType = .done
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(text: String) {
        self.text = text
        placeholderFadeOut(interval: 0.2)
    }
    /// 外部调用 改变占位符显示与否
    var isPlaceholderHidden: Bool = false {
        didSet {
            if isPlaceholderHidden == false {
                // gonna show
                placeholderLabel.alpha = 1
            }
            placeholderLabel.isHidden = isPlaceholderHidden }
    }
    func placeholderFadeOut(interval: TimeInterval = 0.5) {
        UIView.animate(withDuration: interval, animations: {
            self.placeholderLabel.alpha = 0
        }) { (_) in
            self.placeholderLabel.isHidden = true
        }
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        inputerWillBeginEditing?() // added at 1.19
        placeholderFadeOut()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            if let handler = textDidClearedHandler {
                handler()
            }
            placeholderLabel.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.placeholderLabel.alpha = 1
            }, completion: { (_) in // In case of the fade animation still under ...
                self.placeholderLabel.isHidden = false
            })
        } else if textView.text.last == "\n" {
            if hideKeyboardWhenTapReturn { self.endEditing(true) }
        }
        else {
            if let handler = textDidChangedHandler {
                handler(textView.text)
            }
            if placeholderLabel.isHidden == false {
                placeholderFadeOut()
                
            }
        }
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool { // Added at 1.19
        inputerWillEndEditing?()
        if textView.text == "" || textView.text == " " {
            isPlaceholderHidden = false
        }
        if textView.text.last == "\n" {
            textView.text = textView.text.withoutLast
        }
        return true
    }
    
}

