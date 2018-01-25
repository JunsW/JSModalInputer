//
//  JSModalInputerConfiguration.swift
//  JSModalInputer
//
//  Created by 王俊硕 on 2018/1/24.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit
let defaultContainerWidth = 300
let defaultContainerHeight = 300

class JSModalInputerConfigurator {
    
    var showWarningButtons = true
    var clearTextBeforeDismiss = true
    var resetKeyboardBeforePresent = true
    var disableButtonWhileEmpty = false
    var darkButtonIfNotEdited = false
    //Inputer Container
    var inputerContainerFrame = CGRect(x: 30, y: 100, width: 315, height: defaultContainerHeight).flWithMask()
    var inputerContainerBackgroundColor = UIColor.white
    //Text View
    var inputerTextViewFrame = CGRect(x: 10, y: 49, width: 295, height: defaultContainerHeight-103).flWithMask(w: 0)
    var inputerTextViewFontSize: CGFloat = 14
    var inputerTextViewTextColor = UIColor.b333333
    var inputerTextViewBackgroundColor = UIColor.defaultBackgroundColor
    var inputerPlaceholderText = "点击输入"
    var inputerPlaceholderTextColor = UIColor.gaaaaaa
    var inputerPlaceholderFontSize = CGFloat(14)
    var showScrollIndicator = false
    //Title Label
    var titleLabelFrame = CGRect(x: 0, y: 12, width: 300, height: 15).flWithMask(w: 0)
    var titleLabelFontSize: CGFloat = 16
    var titleLabelText = "请输入"
    var titleLabelColor = UIColor.b333333

    //Confirm Button
    var confirmButtonFrame = CGRect(x: 10, y: 300-fl(42), width: 315-fl(20), height: 30).flWithMask(y: 0, w: 0)

    var confirmButtonFontSize: CGFloat = 16
    var confirmButtonTitle = "完成"
    var confirmButtonTextColor = UIColor.white
    var confirmButtonBackgroundColor = UIColor.rB40D0E
    //Warning Label
    var warningText = "未保存的信息将丢弃"
    var warningTextColor = UIColor.b333333
    var warningTextFontSize: CGFloat = 14
    //Left Warning Buttons
    var leftWarningButtonFrame = CGRect(x: 10, y: 12, width: 60, height: 25).flWithMask()
    var leftWarningButtonTitle = "确定"
    var leftWarningButtonTextColor = UIColor.white
    var leftWarningButtonFontSize: CGFloat = 14
    var leftWarningButtonColor = UIColor.rB40D0E
    //Right Warning Buttons
    var rightWarningButtonFrame = CGRect(x: 300-fl(10+60), y: 12, width: 60, height: 25).flWithMask(x: 0)
    var rightWarningButtonTitle = "丢弃"
    var rightWarningButtonTextColor = UIColor.white
    var rightWarningButtonColor = UIColor.rB40D0E
    var rightWarningButtonFontSize: CGFloat = 14
    //Animation
    var presentTimeInterval: Double = 0.3
    var dismissTimeInterval: Double = 0.3
    
    init() {
        
    }
}
