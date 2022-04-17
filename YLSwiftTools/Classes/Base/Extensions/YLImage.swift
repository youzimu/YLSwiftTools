//
//  YLImage.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/14.
//

import Foundation

public extension UIImage {
    
    enum YLLinearGradientDirection {
        case vertical   //垂直
        case horizontal //水平
    }
    
    /// 生成纯色的图片
    /// - color：颜色值
    /// - size：生成图片的宽高
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        let context :CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    /// 绘制图片
    /// - color：颜色值
    /// - path：通过UIBezierPath绘制形状
    /// - scale：设置图片的清晰度
    convenience init(color: UIColor, path: UIBezierPath, scale: CGFloat = UIScreen.main.scale) {
        let bounds = path.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.addPath(path.cgPath)
        context.fillPath()
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!, scale: scale, orientation: .up)
    }
    
    /// 生成渐变色的图片
    /// - gradientColor：颜色数组  例：[0xFF8500.yl_color,0x42CC8B.yl_color]
    /// - size: 生成图片的宽高
    /// - startPoint&endPoint    颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    convenience init(gradientColor: [UIColor], size: CGSize = CGSize(width: 1.0, height: 1.0), startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, direction: YLLinearGradientDirection = .horizontal) {
        UIGraphicsBeginImageContext(size)
        let currentContext = UIGraphicsGetCurrentContext()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.closeSubpath()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColor.map {
            $0.cgColor as AnyObject
            } as NSArray

        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        let pathRect = path.boundingBox
        var startPoint: CGPoint, endPoint: CGPoint
        switch direction {
        case .vertical:
            startPoint = CGPoint(x: pathRect.maxY, y: pathRect.minY)
            endPoint = CGPoint(x: pathRect.maxX, y: pathRect.maxY)
        case .horizontal:
            startPoint = CGPoint(x: pathRect.minX, y: pathRect.midY)
            endPoint = CGPoint(x: pathRect.maxX, y: pathRect.midY)
        }
        currentContext?.saveGState()
        currentContext?.addPath(path)
        currentContext?.clip()
        currentContext?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        currentContext?.restoreGState()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = image {
            self.init(cgImage: image.cgImage!)
        } else {
            self.init()
        }
    }
}


// MARK: 缩略图
public extension UIImage {
    
    func yl_resize(_ newSize: CGSize, scale: CGFloat? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale ?? self.scale)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func yl_thumbnail(length: CGFloat) -> UIImage? {
        let size = self.size
        if size.width <= length && size.height <= length {
            return self
        }
        let scale = size.width > size.height ? length / size.width : length / size.height
        let newSize = CGSize(width: scale * size.width, height: scale * size.height)
        return self.yl_resize(newSize)
    }
}

// MARK: 图片信息
public extension UIImage {
    static func yl_pixelValues(fromCGImage imageRef: CGImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int)
    {
        var width = 0
        var height = 0
        var pixelValues: [UInt8]?
        if let imageRef = imageRef {
            width = imageRef.width
            height = imageRef.height
            let bitsPerComponent = imageRef.bitsPerComponent
            let bytesPerRow = imageRef.bytesPerRow
            let totalBytes = height * bytesPerRow
            
            let colorSpace = CGColorSpaceCreateDeviceGray()
            var intensities = [UInt8](repeating: 0, count: totalBytes)
            
            let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0)
            contextRef?.draw(imageRef, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
            
            pixelValues = intensities
        }
        
        return (pixelValues, width, height)
    }
}

// MARK: - Pod组件添加.Pod组件添加.xcassets资源的方法资源的方法
public extension UIImage {
    /// Pod组件添加.Pod组件添加.xcassets资源的方法资源的方法
    /// - bundleName：组件名称，如果组件名为XXX-XXX-XXX样式，应改为XXX_XXX_XXX
    /// - imageName：存放在 .xcassets里的图片
    static func yl_getPodsXcassetsImage(_ bundleName: String, _ imageName: String) -> UIImage? {
        var bundleUrl = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        bundleUrl = bundleUrl?.appendingPathComponent(bundleName)
        bundleUrl = bundleUrl?.appendingPathExtension("framework")
        
        if let tassociateBundleURL = bundleUrl, let associateBunle = Bundle(url: tassociateBundleURL) {
            bundleUrl = associateBunle.url(forResource: bundleName, withExtension: "bundle")
            
            if bundleUrl == nil {
                return nil
            }
            else {
                let bundle = Bundle(url: bundleUrl!)
                
                let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
                
                return image
            }
        }
        else{
            return nil
        }
    }
}

// MARK: - 图片灰度
public extension UIImage {
    /// 图片灰度
    func yl_grayImage(image: UIImage) -> UIImage {
        let imageSize = image.size
        let width = Int(imageSize.width)
        let height = Int(imageSize.height)
        
        // 创建灰度色空间对象
        let spaceRef = CGColorSpaceCreateDeviceGray()
        // 参数指向渲染的绘制内存地址
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: spaceRef, bitmapInfo: CGBitmapInfo().rawValue)!
        // 创建原尺寸空间
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        // 在灰度上下文中画入图片
        context.draw(image.cgImage!, in: rect)
        // 生成灰度图
        let grayImage = UIImage(cgImage: context.makeImage()!)
        return grayImage
    }
}
