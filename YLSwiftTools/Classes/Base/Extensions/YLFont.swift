//
//  YLFont.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/1.
//

import Foundation

public protocol YLFontProtocol {
    
    var yl_ultraLight: UIFont { get }
    var yl_thin: UIFont { get }
    var yl_light: UIFont { get }
    var yl_regular: UIFont { get }
    var yl_medium: UIFont { get }
    var yl_semibold: UIFont { get }
    var yl_bold: UIFont { get }
    var yl_heavy: UIFont { get }
    var yl_black: UIFont { get }
    
    var yl_fontSize: CGFloat { get }
}

extension YLFontProtocol {
    
    public var yl_ultraLight: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .ultraLight) }
    public var yl_thin: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .thin) }
    public var yl_light: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .light) }
    public var yl_regular: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .regular) }
    public var yl_medium: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .medium) }
    public var yl_semibold: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .semibold) }
    public var yl_bold: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .bold) }
    public var yl_heavy: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .heavy) }
    public var yl_black: UIFont { return .systemFont(ofSize: abs(self.yl_fontSize), weight: .black) }

}

extension UInt8: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension Int8: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension UInt16: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension Int16: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension UInt32: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension Int32: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension UInt64: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension Int64: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension UInt: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension Int: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension Float: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}

extension CGFloat: YLFontProtocol {
    public var yl_fontSize: CGFloat { return self }
}

extension NSNumber: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(doubleValue) }
}

extension TimeInterval: YLFontProtocol {
    public var yl_fontSize: CGFloat { return CGFloat(self) }
}


public extension UIFont {
    
    /// 设置等宽字体 " 16.yl_regular.yl_monospaced "
    var yl_monospaced: UIFont {
        let traits = fontDescriptor.object(forKey: .traits) as? [String: Any] ?? [:]
        let weight = traits[UIFontDescriptor.TraitKey.weight.rawValue] as? CGFloat ?? UIFont.Weight.regular.rawValue
        return UIFont.monospacedDigitSystemFont(ofSize: pointSize, weight: UIFont.Weight(weight))
    }
    
}
