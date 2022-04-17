//
//  YLView.swift
//  YLSwiftTools
//
//  Created by 郁学林 on 2022/3/30.
//

import Foundation
import SnapKit
import YYText
public extension UIView {
    
    convenience init(backgroundColor: UIColor = .clear, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
}

// MARK: - 获取ViewController
public extension UIView {
    /// 获取ViewController
    var yl_viewController: UIViewController? {
        
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            
            if let responder = view?.next{

                if responder.isKind(of: UIViewController.self){

                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

// MARK: - 加载
public extension UIView {
    // 默认indicator
    /// MARK: - 没有文字
    func yl_showLoading() {
        
        self.yl_dismissAll()
    
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        bgView.tag = 999
        bgView.backgroundColor = .clear
        self.addSubview(bgView)
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor(hex: "#000000", alpha: 0.5)
        bgView.addSubview(contentView)
        
        var indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            // Fallback on earlier versions
            indicator = UIActivityIndicatorView(style: .whiteLarge)
            
        }
        indicator.color = .white
        contentView.addSubview(indicator)
        
        // 中间内容视图
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        // 加载转圈视图
        indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        indicator.startAnimating()
    }
    
    /// MARK: - toastH：UIActivityIndicatorView 和 messageLabel 横向排列
    func yl_showLoading(toastH toast: String) {
        self.yl_dismissAll()
    
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        bgView.tag = 999
        bgView.backgroundColor = .clear
        self.addSubview(bgView)
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor(hex: "#000000", alpha: 0.5)
        bgView.addSubview(contentView)
        
        var indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        } else {
            // Fallback on earlier versions
            indicator = UIActivityIndicatorView(style: .white)
            
        }
        indicator.color = .white
        contentView.addSubview(indicator)
        
        
        var toastWidth = toast.yl_width(fontSize: 16, height: 36, options: .usesLineFragmentOrigin) + 18
        if toastWidth < 100 {
            toastWidth = 100
        }
        
        let contentViewWidth = toastWidth + 40
        // 中间内容视图
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: contentViewWidth, height: 40))
        }
        
        // 加载转圈视图
        indicator.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        // 文字提示视图
        let messageLabel = YLRedudeCode.createUILabel(text: toast, textColor: .white, font: 16.yl_regular)
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(indicator.snp.right).offset(0)
            make.size.equalTo(CGSize(width: toastWidth, height: 40))
        }
        
        indicator.startAnimating()
    }
    
    /// MARK: - toastV：UIActivityIndicatorView 和 messageLabel 上下排列
    func yl_showLoading(toastV toast: String) {
        self.yl_dismissAll()
    
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        bgView.tag = 999
        bgView.backgroundColor = .clear
        self.addSubview(bgView)
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor(hex: "#000000", alpha: 0.5)
        bgView.addSubview(contentView)
        
        var indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            // Fallback on earlier versions
            indicator = UIActivityIndicatorView(style: .whiteLarge)
            
        }
        indicator.color = .white
        contentView.addSubview(indicator)
        
        var toastWidth = toast.yl_width(fontSize: 16, height: 36, options: .usesLineFragmentOrigin) + 24
        if toastWidth < 100 {
            toastWidth = 100
        }
        let contentViewWidth = toastWidth
        // 中间内容视图
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: contentViewWidth, height: 100))
        }
        
        // 加载转圈视图
        indicator.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        // 文字提示视图
        let messageLabel = YLRedudeCode.createUILabel(text: toast, textColor: .white, font: 16.yl_regular)
        contentView.addSubview(messageLabel)
        messageLabel.textAlignment = .center
        messageLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView).inset(0)
            make.height.equalTo(36)
        }
        
        indicator.startAnimating()
    }
    func yl_hideLoading() {
        self.yl_dismissAll()
    }
    
    func yl_dismissAll() {
        self.viewWithTag(999)?.removeFromSuperview()
    }
}

// MARK: - 空数据
public extension UIView {
    
    /// - upHeight：图片中心点上移高度
    func yl_showEmpty(upHeight: CGFloat? = 0.0) {
        self.yl_showEmptyData(image: YLCommom.yl_getXcassetsImage("YLSwiftTools", "emptyData") ?? UIImage(), title: "暂无数据", upHeight: upHeight)
    }
    
    func yl_showEmptyAction (upHeight: CGFloat? = 0.0, reloadCallback:(() -> Void)?) {
        self.yl_showEmptyDataAction(image: YLCommom.yl_getXcassetsImage("YLSwiftTools", "emptyData") ?? UIImage(), title: "暂无数据", upHeight: upHeight, reloadCallback: reloadCallback)
    }
    
    /// 自定义空数据图片、文字、文字颜色、图片中心点位置
    /// - image：图片
    /// - title：标题
    /// - titleColor：标题颜色
    /// - tapTitleColor：点击按钮字体颜色
    /// - upHeight：图片中心上移高度
    func yl_showEmptyData (image: UIImage, title: String, titleColor: UIColor = "#6C737C".yl_color, upHeight: CGFloat? = 0.0) {
        self.yl_showEmptyDataAction(image: image, title: title, titleColor: titleColor, tapTitleColor: nil, upHeight: upHeight, reloadCallback: nil)
    }
    
    /// 自定义空数据图片、文字、文字颜色、图片中心点位置
    /// - image：图片
    /// - title：标题
    /// - titleColor：标题颜色
    /// - tapTitleColor：点击按钮字体颜色
    /// - upHeight：图片中心上移高度
    /// - reloadCallback：点击回调
    func yl_showEmptyDataAction(image: UIImage, title: String, titleColor: UIColor = "#6C737C".yl_color, tapTitleColor: UIColor? = "#4070FF".yl_color, upHeight: CGFloat? = 0.0, reloadCallback:(() -> Void)?) {
        self.yl_dismissAll()
        
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        bgView.tag = 999
        // 判断读取的图片是 2x还是3x
        let sacle = UIScreen.main.scale
        let imageWidth1 = image.cgImage?.width ?? 0
        let imageHeight1 = image.cgImage?.height ?? 0
        let imageWidth2 = CGFloat(imageWidth1) / sacle
        let imageHeight2 = CGFloat(imageHeight1) / sacle

        let emptyImageView = YLRedudeCode.createUIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth2, height: imageHeight2),
                                                        image: image,
                                                         mode: .scaleAspectFit)
        emptyImageView.center = CGPoint(x: bgView.center.x, y: bgView.center.y - 72 - (upHeight ?? 0.0))
        let emptyTitleLbl = YLRedudeCode.createUILabel(frame: CGRect(x: 20, y: emptyImageView.frame.maxY + 19, width: bgView.frame.size.width - 40, height: 21),
                                                     text: title,
                                                     textColor: titleColor,
                                                     font: 15.yl_regular,
                                                     textAlignment: .center)
        bgView.addSubview(emptyImageView)
        bgView.addSubview(emptyTitleLbl)
        if (reloadCallback != nil)  {
            let reloadTitle = YYLabel(frame: CGRect(x: 20, y: emptyTitleLbl.frame.maxY, width: bgView.frame.size.width - 40, height: 32))
            let reloadString = "点击刷新试试"
            let attribute = NSMutableAttributedString(string:reloadString)
            // 设置文本size
            attribute.yy_setTextHighlight(NSRange(location: 2, length: 2), color: UIColor.blue, backgroundColor: UIColor.clear) { (containView, text, range, rect) in
                yl_Dlog("点击了刷新")
                reloadCallback?()
            }
            // 为文本设置属性
            attribute.yy_alignment = .center
            attribute.yy_font = 14.yl_regular
            attribute.yy_color = titleColor
            attribute.yy_setColor(tapTitleColor, range: NSRange(location: 2, length: 2))
            reloadTitle.attributedText = attribute
            bgView.addSubview(reloadTitle)
        }
        self.addSubview(bgView)
    }
}

// MARK: 视图裁剪圆角
public extension UIView {
    // 切圆角的方式很多，各有优缺点，可以根据项目中用到的多少，选择合适的方法
    /// 视图裁剪部分圆角，对内存的消耗最少，而且渲染快速
    /// - corners: 需要实现为圆角的角，可传入多个
    /// - radii: 圆角半径
    func yl_corner(byRoundingCorners corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight], radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

// MARK: 取特定位置的颜色
public extension UIView {
    /// 取特定位置的颜色
    /// - parameter at: 位置
    /// - returns: 颜色
    func yl_pickColor(at position: CGPoint) -> UIColor? {
        
        // 用来存放目标像素值
        var pixel = [UInt8](repeatElement(0, count: 4))
        // 颜色空间为 RGB，这决定了输出颜色的编码是 RGB 还是其他（比如 YUV）
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 设置位图颜色分布为 RGBA
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        // 设置 context 原点偏移为目标位置所有坐标
        context.translateBy(x: -position.x, y: -position.y)
        // 将图像渲染到 context 中
        layer.render(in: context)
        
        return UIColor(red: CGFloat(pixel[0]) / 255.0,
                       green: CGFloat(pixel[1]) / 255.0,
                       blue: CGFloat(pixel[2]) / 255.0,
                       alpha: CGFloat(pixel[3]) / 255.0)
    }
}

public extension UIView {
    @objc var yl_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame:CGRect = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    @objc var yl_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame:CGRect = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    @objc var yl_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var frame:CGRect = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    @objc var yl_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var frame:CGRect = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    @objc var yl_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = .init(x: newValue, y: self.center.y)
        }
    }
    
    @objc var yl_centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = .init(x: self.center.x, y: newValue)
        }
    }
    
    @objc var yl_width: CGFloat {
        get {
            return self.bounds.width
        }
        set {
            var frame:CGRect = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    @objc var yl_height: CGFloat {
        get {
            return self.bounds.height
        }
        set {
            var frame:CGRect = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    @objc var yl_origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame:CGRect = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    @objc var yl_size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame:CGRect = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}
