//
//  YLDevice.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/14.
//

import Foundation


// MARK: - 设备的系统
public extension UIDevice {
    
    class yl_System {
        /// 系统名+版本
        public static var versionName: String {
            return UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        }
        /// 系统名
        public static var systemName: String {
            return UIDevice.current.systemName
        }
        /// 系统版本
        public static var systemVersion: String {
            return UIDevice.current.systemVersion
        }
        
        /// 每次运行都不一样，不可作为唯一标识
        public static var identify: String {
            return UUID().uuidString
        }
        
        /// 唯一标识符
        public static var currentIdentify: String {
            return UIDevice.current.identifierForVendor?.uuidString ?? ""
        }
        
        /// 机型
        public static var modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            switch identifier {
            case "iPod1,1":  return "iPod Touch 1"
            case "iPod2,1":  return "iPod Touch 2"
            case "iPod3,1":  return "iPod Touch 3"
            case "iPod4,1":  return "iPod Touch 4"
            case "iPod5,1":  return "iPod Touch (5 Gen)"
            case "iPod7,1":   return "iPod Touch 6"
                
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
            case "iPhone4,1":  return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":   return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
            case "iPhone7,2":  return "iPhone 6"
            case "iPhone7,1":  return "iPhone 6 Plus"
            case "iPhone8,1":  return "iPhone 6s"
            case "iPhone8,2":  return "iPhone 6s Plus"
            case "iPhone8,4":  return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":   return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
            case "iPhone10,1","iPhone10,4":   return "iPhone 8"
            case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
            case "iPhone10,3","iPhone10,6":   return "iPhone X"
            case "iPhone11,8":   return "iPhone XR"
            case "iPhone11,2":   return "iPhone XS"
            case "iPhone11,6","iPhone11,4":   return "iPhone XS Max"
            case "iPhone12,1":   return "iPhone 11"
            case "iPhone12,3":   return "iPhone 11 Pro"
            case "iPhone12,5":   return "iPhone 11 Pro Max"
            case "iPhone12,8":   return "iPhone SE2"
            case "iPhone13,1":   return "iPhone 12 mini"
            case "iPhone13,2":   return "iPhone 12"
            case "iPhone13,3":   return "iPhone 12 Pro"
            case "iPhone13,4":   return "iPhone 12 Pro Max"

            case "iPad1,1":   return "iPad"
            case "iPad1,2":   return "iPad 3G"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
            case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
            case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
            case "iPad5,3", "iPad5,4":   return "iPad Air 2"
            case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
            case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"

            case "AppleTV2,1":  return "Apple TV 2"
            case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
            case "AppleTV5,3":   return "Apple TV 4"
            case "i386", "x86_64":   return "Simulator"
            default:  return identifier
            }
        }
    }
}


// MARK: - App 信息
public extension UIDevice {
    
    class yl_App {
        /// app 信息
        public static var infoDictionary: [String : Any]? {
            return Bundle.main.infoDictionary
        }
        
        /// app 版本version
        public static var appVersion: String {
            
            return (infoDictionary?["CFBundleShortVersionString"] ?? "1.0") as! String
        }
        
        /// app 版本build
        public static var appBuild: String {
            
            return (infoDictionary?["CFBundleVersion"] ?? "1") as! String
        }
        
        /// app 版本BundleIdentifier
        public static var appBundleIdentifier: String {
            
            return (infoDictionary?["CFBundleIdentifier"] ?? "") as! String
        }
        
        /// app 版本BundleIdentifier
        public static var appBundleName: String {
            
            return (infoDictionary?["CFBundleName"] ?? "") as! String
        }
    }
    
}
