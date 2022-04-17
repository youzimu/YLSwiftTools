//
//  YLNumber.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/15.
//

import Foundation

private let formatter = NumberFormatter()

extension NSNumber {
    
    /// 返回一个三位添加一个分隔符的字符串
    public var yl_toDecimalString: String? {
        formatter.numberStyle = .decimal
        return formatter.string(from: self)
    }
    
    /// 返回百分数
    public var yl_toPercentString: String? {
        formatter.numberStyle = .percent
        return formatter.string(from: self)
    }
    
}
