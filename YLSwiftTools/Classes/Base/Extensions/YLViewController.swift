//
//  YLViewController.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/15.
//

import Foundation

// MARK: ALERT
public extension UIViewController {

    // + color for title
    func yl_showAlert(title: String, titleColor: UIColor?, message: String, actionTitle: String, style: UIAlertAction.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: actionTitle, style: style)
        if titleColor != nil {
            okAction.setValue(titleColor, forKey: "titleTextColor")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // 有Action事件返回
    func yl_showAlert(title: String, message: String, actionTitle: String, cancelTitle: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            handler?()
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - APP 置灰
public extension UIViewController {
    func yl_showGrayTheme4App(viewTag:Int = 1000) {
        let window = UIApplication.shared.windows.last
        let grayView = UIView()
        grayView.tag = viewTag
        grayView.isUserInteractionEnabled = false
        grayView.frame = UIScreen.main.bounds
        grayView.backgroundColor = .gray
        grayView.layer.compositingFilter = "saturationBlendMode"
        window?.addSubview(grayView)
    }
    
    func yl_hideGrayTheme4App(viewTag:Int = 1000) {
        let window = UIApplication.shared.windows.last
        window?.viewWithTag(viewTag)?.removeFromSuperview()
    }
    
    func yl_showGrayTheme(toWindow: UIWindow?, viewTag:Int = 1000) {
        let grayView = UIView()
        grayView.tag = viewTag
        grayView.isUserInteractionEnabled = false
        grayView.frame = UIScreen.main.bounds
        grayView.backgroundColor = .gray
        grayView.layer.compositingFilter = "saturationBlendMode"
        toWindow?.addSubview(grayView)
    }
    
    func yl_hideGrayTheme(fromWindow: UIWindow?, viewTag:Int = 1000) {
        fromWindow?.viewWithTag(viewTag)?.removeFromSuperview()
    }
}

public extension UIWindow {
    func yl_showGrayThemeWindow(viewTag:Int = 1000) {
        let grayView = UIView()
        grayView.tag = viewTag
        grayView.isUserInteractionEnabled = false
        grayView.frame = UIScreen.main.bounds
        grayView.backgroundColor = .gray
        grayView.layer.compositingFilter = "saturationBlendMode"
        self.addSubview(grayView)
    }
    
    func yl_hideGrayThemeWindow(viewTag:Int = 1000) {
        self.viewWithTag(viewTag)?.removeFromSuperview()
    }
}
