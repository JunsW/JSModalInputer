//
//  JSAlertInputer.swift
//  DoctorOnline
//
//  Created by 王俊硕 on 2018/1/19.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class JSModalInputer: UIView {
    
    typealias JSModalInputerCompletionHandler = ((String)->())?
    /*
     视图本身只是一个容器 高宽等同于屏幕
     */
    private var titleLabel: UILabel!
    private var tapResponder: UIControl!
    private var containerView: UIView! //TODO: CALayer
    private var textInputer: JSTextView!
    private var confirmButton: UIButton!
    private var warningCancelButton: UIButton!
    private var warningConfirmButton: UIButton!
    
    // Actions
    var confirmHandler: ((String)->())?
    var removeHandler: (()->())?
    // State Control
    private var needShowWarning = false
    private var isWarningVisible = false
    private var isEditing = false
    /// 初始化的标题
    private var staticTitle: String = ""
    
    //MARK: 属性设置
    var configuration = JSModalInputerConfigurator()
    /// 键盘类型
    public var inputerKeyboardType: UIKeyboardType = .default { didSet { textInputer.keyboardType = inputerKeyboardType } }
    /// 标题的内容
    public var title: String = "" { didSet { titleLabel.text = title } }
    
    convenience init(title: String) {
        self.init(frame: CGRect(x: 30, y: 100, width: 315, height: 300).flWithMask() , title: title)
    }
    init(options: [JSModalInputerOption]) {
        super.init(frame: CGRect.zero)
        setupConfigurator(options: options)
        frame = configuration.inputerContainerFrame
        setupTapResponder()
        setupContainer()
        [tapResponder, containerView].forEach() {
            self.addSubview($0)
        }
        
        setupTitleLabel(title: title)
        setupInputer()
        setupConfirmButton()
        [titleLabel, textInputer, confirmButton].forEach() {
            containerView.addSubview($0)
        }
    }
    init(frame: CGRect, title: String) {
        // 去掉导航栏高度
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.screenSize))
        setupTapResponder()
        setupContainer()
        [tapResponder, containerView].forEach() {
            self.addSubview($0)
        }
        
        setupTitleLabel(title: title)
        setupInputer()
        setupConfirmButton()
        [titleLabel, textInputer, confirmButton].forEach() {
            containerView.addSubview($0)
        }
        setupWarninngButtons()
        
    }
    deinit {
        print("[JSModalInputer] Deinited]")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// 界面初始化
extension JSModalInputer {
    func setupConfigurator(options: [JSModalInputerOption]) {
        options.forEach() {
            switch $0 {
            case .showWarningButtons(let s): configuration.showWarningButtons = s
            case .clearTextBeforeDismiss(let s): configuration.clearTextBeforeDismiss = s
            case .resetKeyboardBeforePresent(let s): configuration.resetKeyboardBeforePresent = s
            case .disableButtonWhileEmpty(let s): configuration.disableButtonWhileEmpty = s
            case .darkButtonIfNotEdited(let s): configuration.darkButtonIfNotEdited = s
            //Inputer Container
            case .inputerContainerFrame(let frame): configuration.inputerContainerFrame = frame
            case .inputerContainerBackgroundColor(let color): configuration.inputerContainerBackgroundColor = color
            //Text View
            case .inputerTextViewFrame(let frame): configuration.inputerTextViewFrame = frame
            case .inputerTextViewFontSize(let size): configuration.inputerTextViewFontSize = size
            case .inputerTextViewTextColor(let color): configuration.inputerTextViewTextColor = color
            case .inputerTextViewBackgroundColor(let color): configuration.inputerTextViewBackgroundColor = color
            case .inputerPlaceholderText(let text): configuration.inputerPlaceholderText = text
            case .inputerPlaceholderTextColor(let color): configuration.inputerPlaceholderTextColor = color
            case .inputerPlaceholderFontSize(let font): configuration.inputerPlaceholderFontSize = font
            case .showScrollIndicator(let s): configuration.showScrollIndicator = s
            //Title Label
            case .titleLabelFrame(let frame): configuration.titleLabelFrame = frame
            case .titleLabelFontSize(let size): configuration.titleLabelFontSize = size
            case .titleLabelText(let text): configuration.titleLabelText = text
            case .titleLabelColor(let color): configuration.titleLabelColor = color
            //Confirm Button
            case .confirmButtonFrame(let frame): configuration.confirmButtonFrame = frame
            case .confirmButtonFontSize(let size): configuration.confirmButtonFontSize = size
            case .confirmButtonTextColor(let color): configuration.confirmButtonTextColor = color
            case .confirmButtonTitle(let text): configuration.confirmButtonTitle = text
            case .confirmButtonBackgroundColor(let color): configuration.confirmButtonBackgroundColor = color
            //Warning Label
            case .warningText(let text): configuration.warningText = text
            case .warningTextColor(let color): configuration.warningTextColor = color
            case .warningTextFontSize(let size): configuration.warningTextFontSize = size
            //Left Warning Buttons
            case .leftWarningButtonFrame(let frame): configuration.leftWarningButtonFrame = frame
            case .leftWarningButtonTitle(let text): configuration.leftWarningButtonTitle = text
            case .leftWarningButtonTextColor(let color): configuration.leftWarningButtonTextColor = color
            case .leftWarningButtonFontSize(let size): configuration.leftWarningButtonFontSize = size
            case .leftWarningButtonColor(let color): configuration.leftWarningButtonColor = color
            //Right Warning Buttons
            case .rightWarningButtonFrame(let frame): configuration.rightWarningButtonFrame = frame
            case .rightWarningButtonTitle(let text): configuration.rightWarningButtonTitle = text
            case .rightWarningButtonTextColor(let color): configuration.rightWarningButtonTextColor = color
            case .rightWarningButtonFontSize(let size): configuration.rightWarningButtonFontSize = size
            case .rightWarningButtonColor(let text): configuration.rightWarningButtonColor = text
            //Animation
            case .presentTimeInterval(let duration): configuration.presentTimeInterval = duration
            case .dismissTimeInterval(let duration): configuration.dismissTimeInterval = duration
            }
        }
    }
    /// 所有控件的容器
    private func setupContainer () {
        containerView = UIView(frame: configuration.inputerContainerFrame)
        containerView.backgroundColor = configuration.inputerContainerBackgroundColor
        containerView.layer.cornerRadius = 5
    }
    /// 标题
    private func setupTitleLabel(title: String) {
//        CGRect(x: 0, y: 12, width: containerView.bounds.width, height: 15).flWithMask(w: 0)
//        .b333333
        titleLabel = UILabel(frame: configuration.titleLabelFrame, color: configuration.titleLabelColor, fontSize: configuration.titleLabelFontSize, align: .center, text: configuration.titleLabelText)
        titleLabel.numberOfLines = 0
        staticTitle = title
    }
    /// 输入框
    private func setupInputer() {
//        containerView.bounds.flTransform(x: 10, y: 49, w: -20, h: -42-50-12+1)
        textInputer = JSTextView(frame: configuration.inputerTextViewFrame) // 距离底部42 按钮6
        //        textInputer.isPlaceholderHidden = true
//        "点击输入内容"
        textInputer.jsPlaceholder = configuration.inputerPlaceholderText
        // placeholder customize
        textInputer.font = UIFont.systemFont(ofSize: configuration.inputerPlaceholderFontSize)
        textInputer.layer.cornerRadius = 5
        textInputer.backgroundColor = configuration.inputerTextViewBackgroundColor
        
        textInputer.inputerWillBeginEditing = {
            self.isEditing = true
        }
        textInputer.inputerWillEndEditing = {
            self.isEditing = false
        }
        textInputer.textDidChangedHandler = { title in
            if self.configuration.showWarningButtons { self.needShowWarning = true }
            self.confirmButton.isEnabled = true
            self.confirmButton.alpha = 1
        }
        textInputer.textDidClearedHandler = {
            self.needShowWarning = false
            //            self.bottomButton.isEnabled = false
            //            self.bottomButton.alpha = 0.55
        }
    }
    /// 底部确认按钮
    private func setupConfirmButton() {
//        CGRect(x: 10, y: containerView.bounds.height-fl(42), width: containerView.bounds.width-fl(20), height: 30).flWithMask(y: 0, w: 0)
        confirmButton = UIButton(frame: configuration.confirmButtonFrame) // 距离底部6
        
        confirmButton.setTitle(configuration.confirmButtonTitle, for: .normal)
        confirmButton.setTitleColor(configuration.confirmButtonTextColor, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: configuration.confirmButtonFontSize)
        confirmButton.backgroundColor = configuration.confirmButtonBackgroundColor
        confirmButton.layer.cornerRadius = 5
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
    }
    /// 背景取消事件
    private func setupTapResponder() {
        tapResponder = UIControl(frame: bounds)
        tapResponder.backgroundColor = .black
        tapResponder.alpha = 0.55
        tapResponder.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
    }
    private func setupWarninngButtons() {
//        CGRect(x: 10, y: 12, width: 60, height: 25).flWithMask()
        warningCancelButton = UIButton(frame: configuration.leftWarningButtonFrame)
        warningCancelButton.setTitle(configuration.leftWarningButtonTitle, for: .normal)
        warningCancelButton.setTitleColor(configuration.leftWarningButtonTextColor, for: .normal)
        warningCancelButton.backgroundColor = configuration.leftWarningButtonColor
        warningCancelButton.titleLabel?.font = UIFont.systemFont(ofSize: configuration.leftWarningButtonFontSize)
        warningCancelButton.addTarget(self, action: #selector(warningCancelButtonTapped), for: .touchUpInside)

        //        CGRect(x: containerView.bounds.width-fl(10+60), y: 12, width: 60, height: 25).flWithMask(x: 0)
        warningConfirmButton = UIButton(frame: configuration.rightWarningButtonFrame)
        warningConfirmButton.setTitle(configuration.rightWarningButtonTitle, for: .normal)
        warningConfirmButton.setTitleColor(configuration.rightWarningButtonTextColor, for: .normal)
        warningConfirmButton.backgroundColor = configuration.rightWarningButtonColor
        warningConfirmButton.titleLabel?.font = UIFont.systemFont(ofSize: configuration.rightWarningButtonFontSize)
        warningConfirmButton.addTarget(self, action: #selector(warningConfirmButtonTapped), for: .touchUpInside)
        [warningConfirmButton, warningCancelButton].forEach() {
            $0!.layer.cornerRadius = 5
//            $0!.titleLabel?.font = UIFont.systemFont(ofSize: fl(16))
        }
        
    }
}
// 用户交互
extension JSModalInputer {
    // 每次重新调用的时候重置属性
    func reset(title: String, initialText: String?, completion: ((String) -> ())?) {
        self.title = title
        staticTitle = title
        if let text = initialText {
            self.textInputer.text = text
            textInputer.isPlaceholderHidden = true
        } else {
            textInputer.text = ""
            textInputer.isPlaceholderHidden = false
        }
        self.confirmHandler = completion
    }
    func hideWarningButtons() {
        UIView.animate(withDuration: 0.3) {
            [self.warningCancelButton, self.warningConfirmButton].forEach() {
                $0?.removeFromSuperview()
            }
        }
    }
    @objc func warningCancelButtonTapped() {
        isWarningVisible = false
        titleLabel.text = staticTitle
        hideWarningButtons()
        
    }
    @objc func warningConfirmButtonTapped() {
        isWarningVisible = false
        hideWarningButtons()
        dismiss()
    }
    @objc func confirmButtonTapped() {
        endEditing(true)
        
        confirmHandler?(textInputer.text)
        dismiss()
    }
    
    public func show(On viewController: UIViewController) {
        self.alpha = 0
        warningCancelButtonTapped()
        viewController.view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    public func dismiss() {
        // reset state control
        isEditing = false
        needShowWarning = false
        isWarningVisible = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    @objc private func removeTapped() {
        
        if !isEditing {
            if needShowWarning {
                if !isWarningVisible {
                    isWarningVisible = true
                    [warningConfirmButton, warningCancelButton].forEach() {
                        $0!.alpha = 0
                        containerView.addSubview($0!)
                    }
                    UIView.animate(withDuration: 0.3, animations: {
                        [self.warningConfirmButton, self.warningCancelButton].forEach() {
                            $0!.alpha = 1
                        }
                        self.titleLabel.text = "放弃编辑的内容？"
                    })
                }
                
            } else {
                // Remove
                textInputer.text = ""
                removeHandler?()
                dismiss()
            }
        } else {
            endEditing(true)
        }
        
    }
}

