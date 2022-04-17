//
//  DateViewController.swift
//  YLSwiftTools_Example
//
//  Created by youzimu on 2022/4/14.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import YLSwiftTools

class DateViewController: YLBaseViewController {

    // MARK: -  数据初始化
    func setupData() {
        
        
    }
    
    // MARK: - ♻️ Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        
        
    }
    
    deinit {
        yl_Dlog("检测是否有循环引用")
    }
    
}

// MARK: -  🔨 CustomMethod
extension DateViewController {
    
    func setupUI() {
        self.navTitleLabel.text = "Extensions_Dome"
        
        self.view.yl_showEmptyData(image: UIImage(named: "main_noTask")!, title: "没有数据了啊",titleColor: .red, upHeight: 100)
//        self.view.yl_showEmptyDataAction(image: UIImage(named: "main_noTask")!, title: "没有数据了啊",titleColor: .red, tapTitleColor: .blue) {
//
//        }
        //延时 3s 执行
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            DispatchQueue.main.async {
                self.view.yl_dismissAll()
            }
        }
//        self.view.yl_showLoading(toastV: "加载...")
    
//        yl_Dlog(UIAlertAction.yl_propertyNames)
        
//        UIAlertController.yl_showConfirm(message: "温馨提示", in: self) { [weak self] (_) in
//            self?.viewDome()
//        }
//
//        UIAlertController.yl_showAlert(message: "温馨提示")
        
//        yl_showAlert(title: "温馨提示", titleColor: nil, message: "test?", actionTitle: "是", style: .destructive)
        
//        yl_showAlert(title: "温馨提示", message: "test?", actionTitle: "是", cancelTitle: "否") { [weak self] in
//                self?.viewDome()
//        }

    }
    
}

// MARK: - 🎬 ActionMethod
extension DateViewController {
    
    func viewDome() {
        let image = YLRedudeCode.createUIImageView(image: nil)
        view.addSubview(image)
//        image.snp.makeConstraints { make in
//            make.left.equalTo(view)
//            make.top.equalTo(view).offset(100)
//            make.width.height.equalTo(100)
//        }
        image.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
        image.contentMode = .scaleAspectFit
//        image.image = UIImage.init(color: 0xFF8500.yl_color,size: CGSize(width: 100, height: 100))
        image.image = UIImage.init(gradientColor: [0xFF8500.yl_color,0x42CC8B.yl_color],size: CGSize(width: 100, height: 100),direction: .vertical)
        let color1 = image.yl_pickColor(at: CGPoint(x: 90, y: 90))
        yl_Dlog(color1)
        
        let image2 = YLRedudeCode.createUIImageView(image: nil)
        view.addSubview(image2)
//        image2.snp.makeConstraints { make in
//            make.left.equalTo(view)
//            make.top.equalTo(view).offset(300)
//            make.width.height.equalTo(100)
//        }
        image2.backgroundColor = color1
        
        image.yl_corner(byRoundingCorners: [.topLeft], radii: 30)
        image.yl_corner(byRoundingCorners: [.bottomLeft], radii: 30)
        image.yl_corner(radii: 50)
        
        image2.clipsToBounds = true
        image2.layer.cornerRadius = 50
        image2.image = UIImage().yl_grayImage(image: image.image!)
        
    
        image2.frame = CGRect(x: image.yl_right, y: 100, width: 100, height: 200)
//        image2.yl_centerY = image.yl_centerY
        yl_Dlog(image2.yl_bottom)
        image2.yl_bottom = 400
        yl_Dlog(image2.yl_bottom)
        
    }
    
    func imageDome() {
        
        let image = YLRedudeCode.createUIImageView(image: nil)
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(100)
            make.width.height.equalTo(100)
        }
//        image.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        image.contentMode = .scaleAspectFit
        image.image = UIImage.init(color: 0xFF8500.yl_color,size: CGSize(width: 100, height: 100))
        
        //绘制多边形形
        let trianglePath = UIBezierPath()
        var point = CGPoint(x: 0, y: 0)
        trianglePath.move(to: point)
        point = CGPoint(x: 100, y: 0)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 100, y: 100)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 70, y: 30)
        trianglePath.addLine(to: point)
        trianglePath.close()
//        image.image = UIImage.init(color: 0x223322.yl_color,path: trianglePath)
        
        // 渐变
//        image.image = UIImage.init(gradientColor: [0xFF8500.yl_color,0x42CC8B.yl_color],size: CGSize(width: 100, height: 100),direction: .vertical)
//
//        let sss = UIImage.yl_pixelValues(fromCGImage: image.image?.cgImage)
//        yl_Dlog(sss)
        
//        image.image = UIImage.yl_getPodsXcassetsImage("", "")
        
        
    }
    
    func gestureRecognizerDome() {
        let label = YLRedudeCode.createUILabel(text: "tap", textColor: .white, font: 24.yl_medium)
        label.backgroundColor = .red
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(100)
            make.width.height.equalTo(100)
        }
        
        label.yl_whenTapped { [weak self] in
            self?.tapClicked()
        }
    }
    
    func tapClicked() {
        yl_Dlog("tap clicked")
    }
    
    func deviceDome() {
        yl_Dlog(UIDevice.yl_System.versionName)
        yl_Dlog(UIDevice.yl_System.systemName)
        yl_Dlog(UIDevice.yl_System.systemVersion)
        yl_Dlog(UIDevice.yl_System.identify)
        yl_Dlog(UIDevice.yl_System.modelName)

        let ttt = UIDevice.yl_App.appVersion
        yl_Dlog(ttt)
        
        yl_Dlog(UIDevice.yl_App.infoDictionary)
        yl_Dlog(UIDevice.yl_App.appVersion)
        yl_Dlog(UIDevice.yl_App.appBuild)
        yl_Dlog(UIDevice.yl_App.appBundleName)
        yl_Dlog(UIDevice.yl_App.appBundleIdentifier)
    }
    
    func dataDome() {
        let calendar = Calendar.init(identifier: .gregorian)
        var comps:DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: Date())
        yl_Dlog(comps)
        //        comps.year!                 // 年
        //        comps.month!                // 月
        //        comps.day!                  // 日
        //        comps.hour!                 // 小时
        //        comps.minute!               // 分钟
        //        comps.second!               // 秒
        //        comps.weekday! - 1          //星期
        
        yl_Dlog(Date().yl_weekday)
        let test1 = Date().yl_toString("yyyy-MM-dd HH:mm:ss")
        let test2 = Date().yl_toString(.utc)
        yl_Dlog(test1)
        yl_Dlog(test2)
        
        //样例1
        let str1 = "2012-04-03 19:13:12"
        let date1 = string2Date(str1)
        print("原始字符串1：", str1)
        print("日期1：", date1)
        
        yl_Dlog(date1.yl_toString(.yyyyMMddHHmmss_Dash))
        yl_Dlog(date1.yl_format(to: .yyyyMMddHHmmss_Dash))
        
        let test3 = date2String(date1)
        yl_Dlog(test3)
        
        yl_Dlog(date1.yl_formatDisplay)
    }
    
    
    func stringDome() {
        
        ///样例1
        let str1 = "2022-04-13T06:07:05.000+00:00"
        let date1 = string2Date(str1, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        print("原始字符串1：", str1)
        print("日期1：", date1)
        yl_Dlog(date1.yl_toString("yyyy-MM-dd HH:mm:ss"))
        
        let str2 = str1.yl_format(from: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "yyyy-MM-dd HH:mm:ss")
        yl_Dlog(str2)

    }
}


// MARK: - 🪐 other
extension DateViewController {
    
    //字符串 -> 日期
    func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    //日期 -> 字符串
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    func getLocalDate(from UTCDate: String) -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let locale = Locale(identifier: "en_US")
        dateFormatter.locale = locale

        guard let dateFormatted = dateFormatter.date(from: UTCDate) else {
            return ""
        }

        // 输出格式
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: dateFormatted)

        return dateString
    }
    
    // 部分说明："en_US_POSIX" 与 "zn_CH"、"en_US" 的选择
    // "en_US_POSIX" 适用的范围比 "zn_CH"、"en_US"广，如果与后台交互让"字符串"与"时间"转换建议选择"en_US_POSIX"
    // Apple 官网解释：“en_US_POSIX” is also invariant in time (if the US, at some point in the future, changes the way it formats dates, “en_US” will change to reflect the new behaviour, but “en_US_POSIX” will not), and between machines (“en_US_POSIX” works the same on iPhone OS as it does on Mac OS X, and as it it does on other platforms).
}

