//
//  YLColor.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/13.
//

import Foundation

public extension UIColor {
    
    /// UIColor(r: 95, g: 199, b: 220)，透明度（0 ~ 1）
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// UIColor(hex: 0x5fc7dc)，透明度（0 ~ 1）
    convenience init(hex: UInt64, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16)
        let g = CGFloat((hex & 0x00ff00) >> 8)
        let b = CGFloat( hex & 0x0000ff)
        self.init(r, g, b, a: alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let formattedHEX = hex
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
            .replacingOccurrences(of: "#" , with: "")
        let scanner = Scanner(string: "0x\(formattedHEX)")
        // MARK: - 'scanLocation' was deprecated in iOS 13.0
        var hexInt: UInt64 = 0
        scanner.scanHexInt64(&hexInt)
        self.init(hex: hexInt, alpha: alpha)
    }
    
    /// 获取颜色对应的16进制数值
    var yl_toHexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "0x%02X%02X%02X", Int(r * 0xff), Int(g * 0xff), Int(b * 0xff))
    }
    
    /// 随机色 UIColor.random
    static var yl_random: UIColor {
        return UIColor(CGFloat(arc4random_uniform(256)),
                       CGFloat(arc4random_uniform(256)),
                       CGFloat(arc4random_uniform(256)))
    }
    
}



public protocol YLColorProtocol {
    var yl_color: UIColor { get }
}

extension String: YLColorProtocol {
    ///  例："0x3276FF".yl_color、"0X3276FF".yl_color、"#3276FF".yl_color
    public var yl_color: UIColor {
        let formattedHEX = self
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
            .replacingOccurrences(of: "#" , with: "")
        let scanner = Scanner(string: "0x\(formattedHEX)")
        var hexInt: UInt64 = 0
        scanner.scanHexInt64(&hexInt)
        return UIColor(hex: hexInt)
    }
    
    
}


extension Int: YLColorProtocol {
    ///  例：0x3276FF.yl_color
    public var yl_color: UIColor {
        let r = CGFloat((self & 0xff0000) >> 16)
        let g = CGFloat((self & 0x00ff00) >> 8)
        let b = CGFloat( self & 0x0000ff)
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
}
