//
//  YLGestureRecognizer.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/14.
//

import Foundation

typealias YLTapGestureHanler = () -> Void

///添加点击事件协议
protocol UIViewTapable {
    ///单击事件
    var tapHandlers: [YLTapGestureHanler] { get }
    ///双击事件
    var doubleTapGestureHandlers: [YLTapGestureHanler]{ get }
    ///长点事件
    var longTapGestureHandlers: [YLTapGestureHanler]{ get }
    ///上滑事件
    var upSwipeGestureHandlers: [YLTapGestureHanler]{ get }
    ///左滑事件
    var leftSwipeGestureHandlers: [YLTapGestureHanler]{ get }
    ///右滑事件
    var rightSwipeGestureHandlers: [YLTapGestureHanler]{ get }
    ///下滑事件
    var downSwipeGestureHandlers: [YLTapGestureHanler]{ get }

    func yl_whenTapped(handler:@escaping()->Void)
    func yl_whenDoubleTapped(handler:@escaping()->Void)
    func yl_whenLongPressed(minDuration: TimeInterval, handler:@escaping()->Void)
    func yl_whenUpSwiped(handler:@escaping()->Void)
    func yl_whenLeftSwiped(handler:@escaping()->Void)
    func yl_whenRightSwiped(handler:@escaping()->Void)
    func yl_whenDownSwiped(handler:@escaping()->Void)

}

///runtime绑定方法时的key
class YLGestureAssociatedObjectKey {
    ///设置不同手势不同String标识
    /* 这里有一个问题，使用超过9位的String作为标识，无法获取指针。是swift5才出现大的问题，不确定原因 **/
    static let YLTapGestureAssociatedObjectString  = "YL_Tap"
    ///获取String标识的内存地址作为runtime属性的Key
    static var YLTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let YLDoubleTapGestureAssociatedObjectString  = "YL_Tap2"
    static var YLDoubleTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLDoubleTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let YLLongTapGestureAssociatedObjectString  = "YL_TapL"
    static var YLLongTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLLongTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let YLUpSwipeGestureAssociatedObjectString  = "YL_SwpU"
    static var YLUpSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLUpSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let YLLeftSwipeGestureAssociatedObjectString  = "YL_SwpL"
    static var YLLeftSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLLeftSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let YLRightSwipeGestureAssociatedObjectString  = "YL_SwpR"
    static var YLRightSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLRightSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let YLDownSwipeGestureAssociatedObjectString  = "YL_SwpD"
    static var YLDownSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(YLGestureAssociatedObjectKey.YLDownSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

}

extension UIView: UIViewTapable {
    var tapHandlers: [YLTapGestureHanler] {
        return YLOneTapGesture.tappedHandler
    }
    var doubleTapGestureHandlers: [YLTapGestureHanler] {
        return YLDoubleTapGesture.tappedHandler
    }
    var longTapGestureHandlers: [YLTapGestureHanler] {
        return YLLongTapGesture.tappedHandler
    }
    var upSwipeGestureHandlers: [YLTapGestureHanler] {
        return YLUpSwipeGesture.tappedHandler
    }
    var leftSwipeGestureHandlers: [YLTapGestureHanler] {
        return YLLeftSwipeGesture.tappedHandler
    }
    var rightSwipeGestureHandlers: [YLTapGestureHanler] {
        return YLRightSwipeGesture.tappedHandler
    }
    var downSwipeGestureHandlers: [YLTapGestureHanler] {
        return YLDownSwipeGesture.tappedHandler
    }
    ///runtime的方式为View设置手势属性
    var YLOneTapGesture: YLTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLTapGestureKey) as? YLTapGesture {
                return obj
            }
            let tapGesture = YLTapGesture(view: self)
            tapGesture.gesture.require(toFail: YLDoubleTapGesture.gesture)
            return tapGesture
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var YLDoubleTapGesture: YLTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLDoubleTapGestureKey) as? YLTapGesture {
                return obj
            }
            return YLTapGesture(view: self,taps: 2)
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLDoubleTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var YLLongTapGesture:YLLongPressGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLLongTapGestureKey) as? YLLongPressGesture {
                return obj
            }
            return YLLongPressGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLLongTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var YLUpSwipeGesture: YLSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLUpSwipeGestureKey) as? YLSwipeGesture {
                return obj
            }
            return YLSwipeGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLUpSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var YLLeftSwipeGesture: YLSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLLeftSwipeGestureKey) as? YLSwipeGesture {
                return obj
            }
            return YLSwipeGesture(view: self, direction: .left)
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLLeftSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var YLRightSwipeGesture: YLSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLRightSwipeGestureKey) as? YLSwipeGesture {
                return obj
            }
            return YLSwipeGesture(view: self, direction: .right)
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLRightSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var YLDownSwipeGesture: YLSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, YLGestureAssociatedObjectKey.YLDownSwipeGestureKey) as? YLSwipeGesture {
                return obj
            }
            return YLSwipeGesture(view: self, direction: .down)
        }
        set {
            objc_setAssociatedObject(self, YLGestureAssociatedObjectKey.YLDownSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func yl_whenTapped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLOneTapGesture.registerHandler(handler)
    }

    public func yl_whenDoubleTapped(handler:@escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLDoubleTapGesture.registerHandler(handler)
    }

    public func yl_whenLongPressed(minDuration: TimeInterval = 1, handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLLongTapGesture.registerHandler(minDuration, handler)
    }

    public func yl_whenUpSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLUpSwipeGesture.registerHandler(handler)
    }

    public func yl_whenLeftSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLLeftSwipeGesture.registerHandler(handler)
    }

    public func yl_whenRightSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLRightSwipeGesture.registerHandler(handler)
    }

    public func yl_whenDownSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.YLDownSwipeGesture.registerHandler(handler)
    }

}
///单击双击手势
class YLTapGesture {
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UITapGestureRecognizer
    ///手势储存外界闭包
    fileprivate var tappedHandler = [YLTapGestureHanler]()

    init(view: UIView,taps: Int = 1) {
        myView = view
        ///手势
        gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = taps
        gesture.addTarget(self, action: #selector(YLTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        if taps == 1 {
            myView.YLOneTapGesture = self
        } else if taps == 2 {
            myView.YLDoubleTapGesture = self
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///将外界传入的block传入手势方法
    fileprivate func registerHandler(_ handler:@escaping YLTapGestureHanler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            handler()
        }
    }
}

///长按手势
class YLLongPressGesture {
    typealias YLLongPressGestureHandler = () -> Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UILongPressGestureRecognizer
    fileprivate var tappedHandler = [YLLongPressGestureHandler]()

    init(view:UIView, taps:Int = 1) {
        myView = view
        gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = TimeInterval(taps)
        gesture.addTarget(self, action: #selector(YLTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        myView.YLLongTapGesture = self
    }
    ///将外界传入的block传入手势方法
    fileprivate func registerHandler(_ minDuration: TimeInterval, _ handler:@escaping YLLongPressGestureHandler) {
        self.tappedHandler.append(handler)
        self.gesture.minimumPressDuration = minDuration
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            guard gesture.state == .began else { return }
            handler()
        }
    }
}

///滑动手势
class YLSwipeGesture {
    typealias YLSwipeGestureHandler = () -> Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UISwipeGestureRecognizer
    fileprivate var tappedHandler = [YLSwipeGestureHandler]()

    init(view:UIView,direction: UISwipeGestureRecognizer.Direction = .up) {
        myView = view
        gesture = UISwipeGestureRecognizer()
        gesture.direction = direction
        gesture.addTarget(self, action: #selector(YLTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        switch direction {
        case .up:
            myView.YLUpSwipeGesture = self
        case .left:
            myView.YLLeftSwipeGesture = self
        case .right:
            myView.YLRightSwipeGesture = self
        case .down:
            myView.YLDownSwipeGesture = self
        default:
            return
        }
    }
    fileprivate func registerHandler(_ handler:@escaping YLSwipeGestureHandler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            handler()
        }
    }
}
