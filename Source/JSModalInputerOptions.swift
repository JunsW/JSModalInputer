//
//  JSModalInputerOptions.swift
//  JSModalInputer
//
//  Created by 王俊硕 on 2018/1/23.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit
public enum JSModalInputerOption {
    
    case showWarningButtons(Bool)
    case clearTextBeforeDismiss(Bool)
    case resetKeyboardBeforePresent(Bool)
    case disableButtonWhileEmpty(Bool)
    case darkButtonIfNotEdited(Bool)
    //Inputer Container
    case inputerContainerFrame(CGRect)
    case inputerContainerBackgroundColor(UIColor)
    //Text View
    case inputerTextViewFrame(CGRect)
    case inputerTextViewFontSize(CGFloat)
    case inputerTextViewBackgroundColor(UIColor)
    case inputerTextViewTextColor(UIColor)
    case inputerPlaceholderText(String)
    case inputerPlaceholderTextColor(UIColor)
    case inputerPlaceholderFontSize(CGFloat)
    case showScrollIndicator(Bool)
    //Title Label
    case titleLabelFrame(CGRect)
    case titleLabelFontSize(CGFloat)
    case titleLabelText(String)
    case titleLabelColor(UIColor)
    //Confirm Button
    case confirmButtonFrame(CGRect)
    case confirmButtonFontSize(CGFloat)
    case confirmButtonTitle(String)
    case confirmButtonTextColor(UIColor)
    case confirmButtonBackgroundColor(UIColor)
    //Warning Label
    case warningText(String)
    case warningTextColor(UIColor)
    case warningTextFontSize(CGFloat)
    //Left Warning Buttons
    case leftWarningButtonFrame(CGRect)
    case leftWarningButtonTitle(String)
    case leftWarningButtonTextColor(UIColor)
    case leftWarningButtonFontSize(CGFloat)
    case leftWarningButtonColor(UIColor)
    //Right Warning Buttons
    case rightWarningButtonFrame(CGRect)
    case rightWarningButtonTitle(String)
    case rightWarningButtonTextColor(UIColor)
    case rightWarningButtonFontSize(CGFloat)
    case rightWarningButtonColor(UIColor)
    //Animation
    case presentTimeInterval(Double)
    case dismissTimeInterval(Double)
    
    
}
