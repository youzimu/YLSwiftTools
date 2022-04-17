//
//  YLArray.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/13.
//

import Foundation

public extension Array {
    
    /// 格式化成 JSON 数据
    var yl_toJSON: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
    /// 式化成 JSON 数据，根据传入的 options 格式成打印的样式，或其他格式
    func yl_toJSON(withWritingOptions options: JSONSerialization.WritingOptions = [.prettyPrinted]) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
}

public extension Array where Element: Equatable {
    /// 从Array中移除某个items
    @discardableResult
    mutating func yl_removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }

    /// 从Array中移除items参数中包含的所有实例
    @discardableResult
    mutating func yl_removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// 从Array中删除所有重复的元素
    func yl_withoutDuplicates() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
}
