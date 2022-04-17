//
//  YLAlertController.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/15.
//

import Foundation

public extension UIAlertController {
    /// 在指定视图控制器上弹出普通消息提示框
    static func yl_showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
     
    /// 在根视图控制器上弹出普通消息提示框
    static func yl_showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            yl_showAlert(message: message, in: vc)
        }
    }
     
    /// 在指定视图控制器上弹出确认框
    static func yl_showConfirm(title: String? = nil, message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
     
    /// 在根视图控制器上弹出确认框
    static func yl_showConfirm(title: String? = nil, message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            yl_showConfirm(title: title, message: message, in: vc, confirm: confirm)
        }
    }
}
