//
//  Macros.swift
//  JSModalInputer
//
//  Created by 王俊硕 on 2018/1/23.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScale = kScreenWidth/375

let fl: (CGFloat)->(CGFloat) = { value in
    return value*kScale
}

extension UILabel {
    public convenience init(frame: CGRect, color: UIColor, fontSize size: CGFloat, align: NSTextAlignment, text: String = "") {
        self.init(frame: frame)
        self.textColor = color
        self.font = .systemFont(ofSize: fl(size))
        self.textAlignment = align
        self.text = text
    }
}
extension CGSize {
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}
extension String {
    
    var withoutLast: String {
        return String(dropLast())
    }
}

extension CGRect {
    /// 传入1设置为fl()
    func flWithMask(x: Int = 1, y: Int = 1, w: Int = 1, h: Int = 1) -> CGRect {
        return CGRect(x: x == 0 ? origin.x : fl(origin.x), y: y == 0 ? origin.y : fl(origin.y), width: w == 0 ? width : fl(width), height: h == 0 ? height : fl(height))
    }
    func flTransform(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) -> CGRect {
        return CGRect(x: origin.x + fl(x), y: origin.y + fl(y), width: width + fl(w), height: height + fl(h))
    }
}

extension UIColor {
    class func from(hex: Int) -> UIColor {
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
    class var defaultBackgroundColor: UIColor {
        get { return UIColor.from(hex: 0xf8f8f8) }
    }
    class var rA70001: UIColor {
        get { return UIColor.from(hex: 0xA70001) }
    }
    class var rB40D0E: UIColor {
        get { return UIColor.from(hex: 0xB40D0E) }
    }
    class var b333333: UIColor {
        get { return UIColor.from(hex: 0x333333) }
    }
    class var b666666: UIColor {
        get { return UIColor.from(hex: 0x666666) }
    }
    class var weeeeee: UIColor {
        get { return UIColor.from(hex: 0xeeeeee) }
    }
    class var gaaaaaa: UIColor {
        get { return UIColor.from(hex: 0xaaaaaa) }
    }
    
}

