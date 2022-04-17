//
//  YLDate.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/14.
//

import Foundation

public enum YLDateFormatter: String, CaseIterable {
    
    case utc = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 世界统一时间'UTC'  "2022-03-20T13:45:33.873+0000"
    case utc_unSSSZ = "yyyy-MM-dd'T'HH:mm:ss"
    
    case yyyyMMdd = "yyyyMMdd" // "20220320"
    case yyyyMMdd_Dash = "yyyy-MM-dd" // "2022-03-20"
    case yyyyMMdd_Slash = "yyyy/MM/dd" // "2022/03/20"
    case yyyyMMdd_Space = "yyyy MM dd" // "2022 03 20"
    case yyyyMMdd_Chinese = "yyyy年MM月dd日" // "2022年03月20日"
    
    case yyyyMM = "yyyyMM" // "202203"
    case yyyyMM_Dash = "yyyy-MM" // "2022-03"
    case yyyyMM_Slash = "yyyy/MM" // "2022/03"
    case yyyyMM_Space = "yyyy MM" // "2022 03"
    case yyyyMM_Chinese = "yyyy年MM月" // "2022年03月"
    
    case MMdd = "MMdd" // "0320"
    case MMdd_Dash = "MM-dd" // "03-20"
    case MMdd_Slash = "MM/dd" // "03/20"
    case MMdd_Space = "MM dd" // "03 20"
    case MMdd_Chinese = "MM月dd日" // "03月20日"
    
    case yyMMdd = "yyMMdd" // "200320"
    case yyMMdd_Dash = "yy-MM-dd" // "20-03-20"
    case yyMMdd_Slash = "yy/MM/dd" // "20/03/20"
    case yyMMdd_Space = "yy MM dd" // "20 03 20"
    case yyMMdd_Chinese = "yy年MM月dd日" // "20年03月20日"
    
    case yyMM = "yyMM" // "2003"
    case yyMM_Dash = "yy-MM" // "20-03"
    case yyMM_Slash = "yy/MM" // "20/03"
    case yyMM_Space = "yy MM" // "20 03"
    case yyMM_Chinese = "yy年MM月" // "20年03月"
    
    case yyyyMMddHHmm = "yyyyMMddHHmm" // "202203201345"
    case yyyyMMddHHmm_Dash = "yyyy-MM-dd HH:mm" // "2022-03-20 13:45"
    case yyyyMMddHHmm_Slash = "yyyy/MM/dd HH:mm" // "2022/03/20 13:45"
    case yyyyMMddHHmm_Space = "yyyy MM dd HH:mm" // "2022 03 20 13:45"
    case yyyyMMddHHmm_Chinese = "yyyy年MM月dd日 HH时mm分" // "2022年03月20日 13时45分"
    
    case yyyyMMddHHmmss = "yyyyMMddHHmmss" // "20220320134533"
    case yyyyMMddHHmmss_Dash = "yyyy-MM-dd HH:mm:ss" // "2022-03-20 13:45:33"
    case yyyyMMddHHmmss_Slash = "yyyy/MM/dd HH:mm:ss" // "2022/03/20 13:45:33"
    case yyyyMMddHHmmss_Space = "yyyy MM dd HH:mm:ss" // "2022 03 20 13:45:33"
    case yyyyMMddHHmmss_Chinese = "yyyy年MM月dd日 HH时mm分ss秒" // "2022年03月20日 13时45分33秒"
    
    case HHmmss = "HH:mm:ss"
    case HHmmss_Chinese = "HH时mm分ss秒"
    case HHmm = "HH:mm"
    case HHmm_Chinese = "HH时mm分"
    
    case year = "yyyy"
    case month = "MM"
    case day = "dd"
    case hour = "HH"
    case minutes = "mm"
    case seconds = "ss"
    
    case year_Chinese = "yyyy年"
    case month_Chinese = "MM月"
    case day_Chinese = "dd日"
    case hour_Chinese = "HH时"
    case minutes_Chinese = "mm分"
    case seconds_Chinese = "ss秒"
    
}


public extension Date {
    /// 获取当前时间的星期几
    var yl_weekday: String {
        let weekdays = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        let index = Calendar.current.component(.weekday, from: self) - 1
        return weekdays[index]
    }
    
    static func setup(_ dateString: String, formaterString str: String) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = str
        guard let date = dateFormater.date(from: dateString) else {
            print("字符串转时间失败！")
            return nil
        }
        return date
    }
    
    // Date -> 今天、昨天 ...
    var yl_formatDisplay: String? {
        guard let nowDay = Date().dateComponents.day,
            let dateDay = dateComponents.day,
            let nowMonth = Date().dateComponents.month,
            let dateMonth = dateComponents.month,
            let nowYear = Date().dateComponents.year,
            let dateYear = dateComponents.year,
            let dateWeek = weekComponents.weekday
            else { return nil }
        let dateFormatter = DateFormatter()
        if nowYear == dateYear {
            // 今天
            if nowDay == dateDay && nowMonth == dateMonth {
                dateFormatter.dateFormat = "HH:mm"
                // 昨天
            } else if nowDay - dateDay == 1 && (nowMonth == dateMonth || (nowDay == 1 && nowMonth - dateMonth == 1)) {
                dateFormatter.dateFormat = "昨天 HH:mm"
                // 明天
            } else if nowDay - dateDay == -1 && (nowMonth == dateMonth || (dateDay == 1 && nowMonth - dateMonth == -1)) {
                dateFormatter.dateFormat = "明天 HH:mm"
                // 今年 非 今天 昨天 明天
            } else {
                switch dateWeek {
                case 1 ... 7:
                    let texts = ["日", "一", "二", "三", "四", "五", "六"]
                    dateFormatter.dateFormat = "M.d 周\(texts[dateWeek - 1]) HH:mm"
                default: break
                }
            }
            // 跨年
        } else {
            dateFormatter.dateFormat = "yyyy M.d HH:mm"
        }
        
        return dateFormatter.string(from: self)
    }
    
}

public extension Date {
    /// date 转 string
    @discardableResult
    func yl_toString(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    /// date 转 string
    @discardableResult
    func yl_toString(_ dateFormat: YLDateFormatter) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
    
    /// date 转 string
    @discardableResult
    func yl_format(to dateFormat: YLDateFormatter) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
    
}

private extension Date {
    
    var dateComponents: DateComponents {
        return calendar.dateComponents(units, from: self)
    }
    
    var weekComponents: DateComponents {
        return calendar.dateComponents(weekUnits, from: self)
    }
    
    var calendar: Calendar {
        let calendar = Calendar.current
        
        return calendar
    }
    
    var units: Set<Calendar.Component> {
        return [.day, .month, .year]
    }
    
    var weekUnits: Set<Calendar.Component> {
        return units.union([.weekday])
    }
    
}
