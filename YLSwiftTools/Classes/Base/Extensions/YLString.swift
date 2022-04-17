//
//  YLString.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/14.
//

import Foundation

// MARK: - Date与String转换
public extension String {
    /// string 转 date
    @discardableResult
    func yl_toDate(_ dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
    
    /// string 转 date
    @discardableResult
    func yl_toDate(_ dateFormat: YLDateFormatter) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: self)
    }
    
    /// string 转 date
    @discardableResult
    func yl_format(to dateFormat: YLDateFormatter) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: self)
    }
    
    /// string 转 string
    @discardableResult
    func yl_format(from dateFormat1: String, to dateFormat2: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat1
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat2
        return dateFormatter.string(from: date)
    }
    
    
    /// string 转 string
    @discardableResult
    func yl_format(from dateFormat1: YLDateFormatter, to dateFormat2: YLDateFormatter) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat1.rawValue
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat2.rawValue
        return dateFormatter.string(from: date)
    }
    
}

// MARK: - Size
public extension String {
    
    func yl_size(with font: UIFont, drawingSize: CGSize, mode: NSLineBreakMode) -> CGSize {
        var attr = [NSAttributedString.Key:Any]()
        attr[NSAttributedString.Key.font] = font
        if mode != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = mode
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        let options = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue)
        return NSString(string: self).boundingRect(with: drawingSize, options: options , attributes: attr, context: nil).size
    }
    
    /// 根据文本显示的高度计算宽度
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - height: 文本要显示的高度
    ///   - options: 文本显示的格式，有没有行间距等等
    /// - Returns: 返回文本的宽度
    func yl_width(fontSize: CGFloat, height: CGFloat = 15, options: NSStringDrawingOptions = .usesLineFragmentOrigin) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    
    /// 根据文本显示的宽度，计算文本的高度，并使高度不大于设置最大值
    ///
    /// - Parameters:
    ///   - fontSize: 文字大小
    ///   - width: 文本显示的宽度
    ///   - limitedHeight: 文本限制高度，大于此高度则返回此高度
    ///   - options: 文本显示的格式，有没有行间距等等
    /// - Returns: 返回文本高度
    func yl_height(fontSize: CGFloat, width: CGFloat, limitedHeight: CGFloat = CGFloat(MAXFLOAT), options: NSStringDrawingOptions = .usesLineFragmentOrigin) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height) > limitedHeight ? limitedHeight : ceil(rect.height)
    }
    
}

// MARK: - 判断各种字符
public extension String {
    
    /// 字符串为 nil、" "、""、"\n" 返回true
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
    
    /// 是否是有效的网址
    var isValidURL: Bool {
        let pattern = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,6})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,6})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(((http[s]{0,1}|ftp)://|)((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的手机号或电话号码(只验证1开头的11位数字)
    var isValidMobile: Bool {
        let pattern = "^1\\d{10}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否包含小写英文字母
    var isValidLowwer: Bool {
        let pattern = ".*[a-z]+.*"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否包含大写英文字母
    var isValidUpper: Bool {
        let pattern = ".*[A-Z]+.*"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否纯数字
    var isValidNumber: Bool {
        let pattern = "^[0-9]*$"//(/^[0-9]*$/)
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否纯汉字
    var isValidChinese: Bool {
        let pattern = "^[\u{4e00}-\u{9fa5}]+$"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的邮箱
    var isValidEmail: Bool {
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,6}"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的身份证
    var isValidChineseIdCardNum: Bool {
        let idCardNumber = uppercased()// 如果输入字符串中有x，转成大写
        if  idCardNumber.count != 18 { return false }
        // 正则表达式判断基本 身份证号是否满足格式
        let regex = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"
        //let regex = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
        let identityStringPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        //如果通过该验证，说明身份证格式正确，但准确性还需计算
        if !identityStringPredicate.evaluate(with: idCardNumber) { return false }
        
        //** 开始进行校验 *//
        //将前17位加权因子保存在数组里
        let idCardWiArray = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        let idCardYArray = ["1", "0", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
        //用来保存前17位各自乖以加权因子后的总和
        var idCardWiSum = 0
        for i in 0..<17 {
            let subStrIndex = Int((idCardNumber as NSString).substring(with: NSRange(location: i, length: 1)))!
            //let subStrIndex = [[_identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
            let idCardWiIndex = Int(idCardWiArray[i])!
            idCardWiSum += subStrIndex * idCardWiIndex
        }
        //计算出校验码所在数组的位置
        let idCardMod = idCardWiSum % 11
        //得到最后一位身份证号码
        let idCardLast = (idCardNumber as NSString).substring(with: NSRange(location: 17, length: 1))
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if idCardMod == 2 {
            if idCardLast != "X" { return false }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if idCardLast != idCardYArray[idCardMod] {
                return false
            }
        }
        return true
    }
    

    /// 是否是表情符
    var isContainEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x1F1E6...0x1F1FF, // Regional country flags
                 0x2600...0x26FF, // Misc symbols
                 0x2700...0x27BF, // Dingbats
                 0xE0020...0xE007F, // Tags
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 127_000...127_600, // Various asian characters
                 65024...65039, // Variation selector
                 9100...9300, // Misc items
                 8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
}


// MARK: - SubString
public extension String {
    
    /// 移除字符串中的 emoji 表情符号
    var yl_removeEmoji: String {
        return reduce("") { (result, character) -> String in
            if character.isEmoji {
                return result + ""
            } else {
                return result + String(character)
            }
        }
    }

    /// 去掉头尾的空白字符
    var yl_trimTopBottomSpace: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// 去掉整段文字内的所有空白字符（包括换行符）
    var yl_trimAllSpace: String {
        return replacingOccurrences(of: "\\s", with: "", options: .regularExpression, range: range(of: self))
    }

    /// 将文字中的换行符替换为空格
    var yl_trimLinerBreakCharacter: String {
        return replacingOccurrences(of: "\n", with: " ", options: .regularExpression, range: range(of: self))
    }

    
    /// 去掉一段文字中的HTML标签，只保留文字
    var yl_trimHTMLTags: String {
        let regularExpretion = try? NSRegularExpression(pattern: "<[^>]*>|\n|&nbsp", options: NSRegularExpression.Options(rawValue: 0))
        let string = regularExpretion?.stringByReplacingMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.count), withTemplate: "")
        return string ?? self;
    }

    /// 获取字符串 到index终止（包括Index）
    /// - Parameter index: 终止
    /// - Returns: 截取到的字符串
    func yl_subString(to index: Int) -> String? {
        return yl_subString(from: 0, to: index)
    }

    /// 获取字符串 从index到结束
    /// - Parameter index: 起始
    /// - Returns: 截取到的字符串
    func yl_subString(from index: Int) -> String? {
        return yl_subString(from: index, to: self.count-1)
    }

    /// 根据起始终止位置截取一个子字符串 [startIndex, endIndex] 包括起始和结束
    /// - Parameters:
    ///   - startIndex: 起始Index
    ///   - endIndex: 结束Index
    /// - Returns: 截取到的字符串
    func yl_subString(from startIndex: Int, to endIndex: Int) -> String? {

        guard endIndex >= startIndex, self.count > endIndex, startIndex >= 0 else {return nil}
        let startIndex = self.index(self.startIndex, offsetBy: startIndex)
        let endIndex = self.index(self.startIndex, offsetBy: endIndex)
        return String(self[startIndex...endIndex])
    }
    
    /// 根据Range截取子字符串
    /// - Parameters:
    ///   - location: location description
    ///   - length: length description
    /// - Returns: 截取到的字符串
    func yl_subString(location:Int, length: Int) -> String? {
        
        guard location >= 0, length > 0 else {return nil}
        return yl_subString(from: location, to: location+length-1)
    }
    
    /// 根据NSRange截取子字符串
    /// - Parameter range: range description
    /// - Returns: 截取到的字符串
    func yl_subString(with range: NSRange) -> String? {
        return yl_subString(location: range.location, length: range.length)
    }
}

// MARK: - Range -> NSRange
public extension String {
    private func yl_nsRange(from range: Range<String.Index>) -> NSRange? {
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else { return nil }
        
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from), length: utf16.distance(from: from, to: to))
    }
    /// 获取subString在 String 上的 range
    func yl_rangeOfString(_ aString: String) -> NSRange? {
        
        guard let range = self.range(of: aString) ,let nsRange = self.yl_nsRange(from: range) else { return nil }

        return nsRange
    }
}
