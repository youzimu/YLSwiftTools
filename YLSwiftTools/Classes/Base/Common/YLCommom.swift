//
//  YLCommom.swift
//  YLSwiftTools
//
//  Created by 郁学林 on 2022/3/30.
//

import Foundation

// MARK:- 自定义打印日志
public func yl_Dlog(_ messages: Any..., filePath: String = #file, funcName: String = #function, lineNumber: Int = #line) {
    #if DEBUG /// Swift 的 DEBUG 需要在 Settings -> Swift compiler - custom flags -> other flags 下面 DEBUG 选项下添加 -DDEBUG 或者配置成其他 e.g.：-DOTHERFLAG 然后代码中就要写成：#if OTHERFLAG ··· #endif
    // 文件名、方法、行号、打印信息
    print("\n\n")
    print("🤤🍇🍏🍎🍐🍊🍋🍌🍓🍈🍒🍍🥝🍅🌽🤤🍇🍊🍉🍓🍑🍍🤤")
    print("▩◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▩")
    print("————————————————————————————————————————————————")
    let file: NSString = filePath as NSString
    print("😸【文件】 \(file.lastPathComponent.utf8)")
    print("😸【方法】 \(funcName)")
    print("😸【行号】 D \(lineNumber) 行")
    print("😸【信息】 输出\n\(messages)\n\n")
    //print("😸【文件】 \(file.lastPathComponent.utf8)\n😸【方法】 \(funcName)\n😸【行号】 D \(lineNumber) 行\n😸【信息】 输出\n\(messages)\n\n")
    #endif
}

// MARK: - 状态栏高度
public var yl_StatusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

public let yl_ScreenHeight = UIScreen.main.bounds.size.height
public let yl_ScreenWidth  = UIScreen.main.bounds.size.width

public let yl_NavHight: CGFloat = 44.0
public let yl_SafeAreaBottomHeight: CGFloat = (yl_ScreenHeight >= 812.0 ? 34.0 : 0.0)
public let yl_TabBarHeight = (yl_ScreenHeight >= 812.0 ? 83.0 : 49.0)
public let yl_DeviceHeightScale = yl_ScreenHeight / 667.0
public let yl_DeviceWidthScale = yl_ScreenWidth / 375.0

// MARK: - 等比缩放
public func yl_WordSize(_ size:CGFloat) -> CGFloat {
    return size * yl_DeviceWidthScale
}
public func yl_Hight(_ size:CGFloat) -> CGFloat {
    return size * yl_DeviceWidthScale
}
public func yl_Width(_ size:CGFloat) -> CGFloat {
    return size * yl_DeviceWidthScale
}

public class YLCommom: NSObject {
    // MARK: - Pod组件添加.Pod组件添加.xcassets资源的方法资源的方法
    public static func yl_getXcassetsImage(_ bundleName: String, _ imageName: String) -> UIImage? {
        var bundleUrl = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        bundleUrl = bundleUrl?.appendingPathComponent(bundleName)
        bundleUrl = bundleUrl?.appendingPathExtension("framework")
        
        if let tassociateBundleURL = bundleUrl, let associateBunle = Bundle(url: tassociateBundleURL) {
            bundleUrl = associateBunle.url(forResource: bundleName, withExtension: "bundle")
            
            if (bundleUrl != nil) {
                let bundle = Bundle(url: bundleUrl!)
                
                let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
                
                return image
            }
            else{
                return nil
            }
            
        }
        else{
            return nil
        }
    }
    
    // MARK: - 颜色转图片
    public static func yl_ImageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
    
}
