//
//  YLAlertAction.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/15.
//

import Foundation

public extension UIAlertAction {
    /// 取属性列表
    static var yl_propertyNames: [String] {
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(self, &outCount) else {
            return []
        }
        var result = [String]()
        let count = Int(outCount)
        for i in 0..<count {
            let pro: Ivar = ivars[i]
            guard let ivarName = ivar_getName(pro) else {
                continue
            }
            guard let name = String(utf8String: ivarName) else {
                continue
            }
            result.append(name)
        }

        return result
    }
    
    /// 是否存在某个属性
    func isPropertyExisted(_ propertyName: String) -> Bool {
        for name in UIAlertAction.yl_propertyNames {
            if name == propertyName {
                return true
            }
        }
        return false
    }
    
    /// 修改颜色
    func yl_setTextColor(_ color: UIColor) {
        let key = "_titleTextColor"
        guard isPropertyExisted(key) else {
            return
        }
        self.setValue(color, forKey: key)
    }

}
