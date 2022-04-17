//
//  YLRedudeCode.swift
//  MJRefresh
//
//  Created by youzimu on 2022/4/2.
//

import Foundation

public enum YLButtonEdgeInsetsStyle : Int {

    case top = 0                // image在上，label在下

    case left = 1               // image在左，label在右

    case bottom = 2             // image在下，label在上

    case right = 3              // image在右，label在左
}

public class YLRedudeCode: NSObject {
    
    public static func createUILabel(frame: CGRect = CGRect.zero, text: String, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.textColor = textColor
        label.font = font
        label.textAlignment = textAlignment
        return label
    }
    
    public static func createUIImageView(frame: CGRect = CGRect.zero, image: UIImage?, mode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        imageView.contentMode = mode
        return imageView
    }
    
    public static func createUITextField(frame: CGRect = CGRect.zero, placeholderText: String, placeholderTextColor: UIColor, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .left, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.attributedPlaceholder = NSAttributedString.init(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : placeholderTextColor])
        textField.textColor = textColor
        textField.font = font
        textField.textAlignment = textAlignment
        textField.keyboardType = keyboardType
        return textField
    }
    
    public static func createUITextField(frame: CGRect = CGRect.zero, placeholderText: String, placeholderTextColor: UIColor, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .left, leftView: UIView) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.attributedPlaceholder = NSAttributedString.init(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : placeholderTextColor])
        textField.textColor = textColor
        textField.font = font
        textField.textAlignment = textAlignment
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }
    
    public static func createUITextField(frame: CGRect = CGRect.zero, placeholderText: String, placeholderTextColor: UIColor, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .left, rightView: UIView) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.attributedPlaceholder = NSAttributedString.init(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : placeholderTextColor])
        textField.textColor = textColor
        textField.font = font
        textField.textAlignment = textAlignment
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }
    
    public static func createUIButton(frame: CGRect = CGRect.zero, title: String?, titleColor: UIColor?, font: UIFont?, bgColor: UIColor?, image: UIImage?, control: UIControl.State = .normal) -> UIButton {
        let button = UIButton(frame: frame)
        if title?.count ?? 0 > 0 {
            button.setTitle(title, for: control)
            button.setTitleColor(titleColor, for: control)
            button.titleLabel?.font = font
        }
        if image != nil {
            button.setImage(image, for: control)
        }
        button.backgroundColor = bgColor
        
        return button
    }
    
    public static func createUIButton(frame: CGRect = CGRect.zero, title: String, titleColor: UIColor, font: UIFont, titleLabelSize: CGSize, bgColor: UIColor = .white, image: UIImage, imgSize: CGSize, spacing1: CGFloat, spacing2: CGFloat, style: YLButtonEdgeInsetsStyle) -> UIButton {
        
        /*
         1、上图下字   spacing1 图片距top的间距 spacing2 图片与文字间距
            butWidth = titleLabelWidth
            butHeight = spacing1 + imageHeight + spacing2 + titleLabelHeight
         2、左图右字   spacing1 图片距left的间距 spacing2 图片与文字间距
            butWidth = spacing1 + imageWidth + spacing2 + titleLabelWidth
            butHeight = titleLabelHeight
         3、下图上字   spacing1 图片距bottom的间距 spacing2 图片与文字间距
            butWidth = titleLabelWidth
            butHeight = titleLabelHeight + spacing2 + imageHeight + spacing1
         4、右图左字   spacing1 图片距right的间距 spacing2 图片与文字间距
            butWidth = titleLabelWidth + spacing2 + imageWidth + spacing1
            butHeight = titleLabelHeight
         */
        let butWidth = frame.size.width
        let butHeight = frame.size.height
        let titleLabelWidth = titleLabelSize.width
        let titleLabelHeight = titleLabelSize.height
        let imageWidth = imgSize.width
        let imageHeight = imgSize.height
        let butView = UIView(frame: CGRect(x: 0, y: 0, width: butWidth, height: butHeight))
        butView.backgroundColor = bgColor
        let label = createUILabel(text: title, textColor: titleColor, font: font)
        label.textAlignment = .center
        let imgView = createUIImageView(image: image)
        butView.addSubview(label)
        butView.addSubview(imgView)
        switch style {
        case .top: //上图下字，
            label.frame = CGRect(x: 0, y: spacing1 + imageHeight + spacing2, width: titleLabelWidth, height: titleLabelHeight)
            imgView.frame = CGRect(x: (titleLabelWidth - imageWidth) / 2.0, y: spacing1, width: imageWidth, height: imageHeight)
            break
            
        case .left: //左图右字
            label.frame = CGRect(x: spacing1 + imageWidth + spacing2, y: 0, width: titleLabelWidth, height: titleLabelHeight)
            imgView.frame = CGRect(x: spacing1, y: (titleLabelHeight - imageHeight) / 2.0, width: imageWidth, height: imageHeight)
            break
            
        case .bottom: //下图上字
            label.frame = CGRect(x: 0, y: 0, width: titleLabelWidth, height: titleLabelHeight)
            imgView.frame = CGRect(x: (titleLabelWidth - imageWidth) / 2.0, y: titleLabelHeight + spacing2, width: imageWidth, height: imageHeight)
            break
            
        case .right: //右图左字
            label.frame = CGRect(x: 0, y: 0, width: titleLabelWidth, height: titleLabelHeight)
            imgView.frame = CGRect(x: titleLabelWidth + spacing2, y: (titleLabelHeight - imageHeight) / 2.0, width: imageWidth, height: imageHeight)
            break
        }
        
        let button = UIButton(frame: frame)
        button.addSubview(butView)
        return button
    }
}
